//
//  NetworkService.swift
//  Chiff
//
//  Created by Zakirov Tahir on 10.04.2021.
//

import Foundation
import SwiftKeychainWrapper
import UIKit

enum NetworkError: Error {
    case badURL, requestFailed, unknown, errorSignIn
}

protocol NetworkServiceProtocol {
    func getData(page: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
    func getUsernamePost(id: Int, complitionHandler: @escaping (Result<User, Error>) -> Void)
    func getPost(idPost: Int, complitionHandler: @escaping (Result<DetailNews, Error>) -> Void)
    func createNewPost(post: CreatePostModel, complitionHandler: @escaping (Result<String, Error>) -> Void)
    func getImagesFromPosts(idPost: Int, complitionHandler: @escaping (Result<[Media], NetworkError>) -> Void)
    func loadImages(postId: String, images: [UIImage])
    func getProfileInfo(complitionHandler: @escaping (Result<User, NetworkError>) -> Void)
    func getAuth(login: String, password: String, complitionHandler: @escaping (Result<Auth, NetworkError>) -> Void)
    func getRegister()
    func getPosts()
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseUrl = "http://swiftdevs.ru/wp-json"
    
    // Запрос каких либо данных
    func getData(page: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/posts?page=\(page)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let news = try JSONDecoder().decode([News].self, from: data)
                complitionHandler(.success(news))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
        
    }
    
    // Получаем пользователя, запостивший пост ))))
    func getUsernamePost(id: Int, complitionHandler: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/users/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                complitionHandler(.success(user))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
        
    }
    
    // Запрашиваем изображения для постов
    func getImagesFromPosts(idPost: Int, complitionHandler: @escaping (Result<[Media], NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/media?parent=\(idPost)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data else { return }

            do {
                let media = try JSONDecoder().decode([Media].self, from: data)
                complitionHandler(.success(media))
            } catch {
                complitionHandler(.failure(.requestFailed))
            }
            
        }.resume()
        
    }
    
    // Запрашиваем пост с детальной информцией
    func getPost(idPost: Int, complitionHandler: @escaping (Result<DetailNews, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/posts/\(idPost)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else { return }
            
            do {
                let post = try JSONDecoder().decode(DetailNews.self, from: data)
                complitionHandler(.success(post))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
        
    }
    
    // Отправляем POST запрос, для создания поста
    func createNewPost(post: CreatePostModel, complitionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/posts") else { return }
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        
        let object = ["title": post.title ?? "",
                      "content": post.content ?? "",
                      "status": post.status ?? "",
                      "cost": post.cost ?? ""
        ] as [String: Any]
        
        let httpBody = try? JSONSerialization.data(withJSONObject: object, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.allHTTPHeaderFields = headers
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return complitionHandler(.failure(error as! Error))
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                
                guard let response = responseJSON["id"] as? Int else { return }
                
                if !(post.images?.isEmpty ?? false) {
                    self.loadImages(postId: String(response), images: post.images ?? [UIImage()])
                }
                
                complitionHandler(.success("Ok"))
            }
            
        }.resume()
        
    }
    
    // Отправляем изображение на сервер, получаем ссылку для поста
    func loadImages(postId: String, images: [UIImage]) {
        guard let url = URL(string: "\(baseUrl)/wp/v2/media") else { return }
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        for image in images {
            print(image)
            let filename = "avatar.png"
            let boundary = UUID().uuidString
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            var data = Data()
            // post - id
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"post\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(postId)".data(using: .utf8)!)
            // file - image
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.jpegData(compressionQuality: 1) ?? Data())
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                
                if(error != nil){
                    print("\(error!.localizedDescription)")
                }
                
                guard let responseData = responseData else {
                    print("no response data")
                    return
                }
                
                if let responseString = String(data: responseData, encoding: .utf8) {
                    print("uploaded to: \(responseString)")
                }
                
            }).resume()
        }
        
    }
    
    
    
    // Информация о пользователе
    func getProfileInfo(complitionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/users/1") else { return }
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "GET"
        loginRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                complitionHandler(.failure(.errorSignIn))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                complitionHandler(.success(user))
            } catch {
                print("ошибка \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
    // Аутентификация и авторизация
    func getAuth(login: String, password: String, complitionHandler: @escaping (Result<Auth, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/jwt-auth/v1/token") else { return }
        
        let headers = ["Content-Type": "application/json", "cache-control": "no-cache"]
        let parameters = ["username": login, "password": password] as [String: Any]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "POST"
        loginRequest.allHTTPHeaderFields = headers
        loginRequest.httpBody = postData
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            if error != nil {
                print("LOG: ОШИБКА ПОЛУЧЕНИЯ ДАННЫХ")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                complitionHandler(.failure(.errorSignIn))
                return
            }
            
            
            guard let data = data else { return }
            
            // Нужно сохранить в кейчейн данные
            do {
                let auth = try JSONDecoder().decode(Auth.self, from: data)
                
                KeychainWrapper.standard.set(auth.token ?? "", forKey: "token")
                KeychainWrapper.standard.set(auth.user_email ?? "", forKey: "user_email")
                KeychainWrapper.standard.set(auth.user_nicename ?? "", forKey: "user_nicename")
                KeychainWrapper.standard.set(auth.user_display_name ?? "", forKey: "user_display_name")
                
                print("LOG: TOKEN \(String(describing: auth.token))")
                
                complitionHandler(.success(auth))
            } catch let error {
                complitionHandler(.failure(.errorSignIn))
            }
            
        }.resume()
    }
    
    // Регистрация
    func getRegister() {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/users/register") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let parameters = ["username": "1newpers", "email": "aaa1@mail.ru", "password": "zasazasa"] as [String: Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("не получилось создать пользователя: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Error two")
                return
            }
            
            guard let data = data else { return }
            // доработать
            print(data)
            print(response ?? "РЕСПОНСА НЕТ")
            
        }.resume()
    }
    
    func getPosts() {
        
        
    }
    
    
}
