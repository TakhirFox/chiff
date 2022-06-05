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
    case badURL, requestFailed, unknown, errorSignIn, noNetwork
}

protocol NetworkServiceProtocol {
    func getData(page: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
    func getCategories(complitionHandler: @escaping (Result<[Categories], Error>) -> Void)
    func getPostFromCategory(id: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
    func getUsernamePost(id: Int, complitionHandler: @escaping (Result<User, Error>) -> Void)
    func getPost(idPost: Int, complitionHandler: @escaping (Result<News, Error>) -> Void)
    func getSimilarPost(idPost: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
    func createNewPost(post: CreatePostModel, complitionHandler: @escaping (Result<Int, Error>) -> Void)
    func getImagesFromPosts(idPost: Int, complitionHandler: @escaping (Result<[Media], NetworkError>) -> Void)
    func loadImages(postId: String, images: [UIImage])
    func getProfileInfo(complitionHandler: @escaping (Result<User, NetworkError>) -> Void)
    func editProfile(userId: Int, params: String, complitionHandler: @escaping (Result<User, NetworkError>) -> Void)
    func getPostsForProfile(userId: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
    func getAuth(login: String, password: String, complitionHandler: @escaping (Result<Auth, NetworkError>) -> Void)
    func getRegister()
    func getPosts()
    
    // Messages
    func getChatList(complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void)
    func getMessages(id: Int, complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void)
    func sendMessageTo(id: Int, message: String, recipients: Int, complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let baseUrl = "http://swiftdevs.ru"
    
    // Запрос каких либо данных
    func getData(page: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/posts?page=\(page)") else { return }
        
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
    
    // Получить все категории
    func getCategories(complitionHandler: @escaping (Result<[Categories], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/categories?per_page=20") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let categories = try JSONDecoder().decode([Categories].self, from: data)
                complitionHandler(.success(categories))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
    }
    
    // Получить посты выбранной категории
    func getPostFromCategory(id: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/posts?categories=\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode([News].self, from: data)
                complitionHandler(.success(posts))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
    }
    
    // Получаем пользователя, запостивший пост ))))
    func getUsernamePost(id: Int, complitionHandler: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/users/\(id)") else { return }

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
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/media?parent=\(idPost)") else { return }
        
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
    func getPost(idPost: Int, complitionHandler: @escaping (Result<News, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/posts/\(idPost)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else { return }
            
            do {
                let post = try JSONDecoder().decode(News.self, from: data)
                complitionHandler(.success(post))
            } catch {
                complitionHandler(.failure(error))
            }
            
        }.resume()
        
    }
    
    func getSimilarPost(idPost: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/wp-json/contextual-related-posts/v1/posts/\(idPost)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let similar = try JSONDecoder().decode([News].self, from: data)
                complitionHandler(.success(similar))
            } catch {
                complitionHandler(.failure(error))
            }
        }.resume()
    }

    
    // Отправляем POST запрос, для создания поста
    func createNewPost(post: CreatePostModel, complitionHandler: @escaping (Result<Int, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/posts") else { return }
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        
        let object = ["title": post.title ?? "",
                      "categories": [post.category],
                      "cost": post.cost ?? "",
                      "content": post.description ?? "",
                      "status": "publish"
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
                
                guard let responseID = responseJSON["id"] as? Int else { return }
                
                if !(post.images?.isEmpty ?? false) {
                    self.loadImages(postId: String(responseID), images: post.images ?? [UIImage()])
                }
                
                complitionHandler(.success(responseID))
            }
            
        }.resume()
        
    }
    
    // Отправляем изображение на сервер, получаем ссылку для поста
    func loadImages(postId: String, images: [UIImage]) {
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/media") else { return }
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
                    print("LOG: \(error!.localizedDescription)")
                }
                
                guard let responseData = responseData else {
                    print("LOG: no response data")
                    return
                }
                
                if let responseString = String(data: responseData, encoding: .utf8) {
                    print("LOG: uploaded to: \(responseString)")
                }
                
            }).resume()
        }
        
    }
    
    
    func editProfile(userId: Int, params: String, complitionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }

        guard let urlString = "\(baseUrl)/wp-json/wp/v2/users/\(userId)?\(params)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        
        guard let url = URL(string: urlString) else { return }

        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "PUT"
        loginRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("LOG: statusCode \(response)")
                complitionHandler(.failure(.errorSignIn))
                return
            }

            guard let data = data else { return }

            do {
                let editUser = try JSONDecoder().decode(User.self, from: data)
                complitionHandler(.success(editUser))
            } catch {
                print("LOG: ошибка \(error.localizedDescription)")
            }

        }.resume()
        
    }
    
    
    // Информация о пользователе
    func getProfileInfo(complitionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/users/me") else { return }
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
                print("LOG: ошибка \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
    // Аутентификация и авторизация
    func getAuth(login: String, password: String, complitionHandler: @escaping (Result<Auth, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp-json/jwt-auth/v1/token") else { return }
        
        let headers = ["Content-Type": "application/json", "cache-control": "no-cache"]
        let parameters = ["username": login, "password": password] as [String: Any]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "POST"
        loginRequest.allHTTPHeaderFields = headers
        loginRequest.httpBody = postData
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            if error != nil {
                complitionHandler(.failure(.noNetwork))
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
        
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/users/register") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let parameters = ["username": "d1newPers",
                          "email": "1qaada1@mail.ru",
                          "password": "zasazasa",
                          "firstname": "1IadmSkatman"
        ] as [String: Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("LOG: не получилось создать пользователя: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("LOG: Error two")
                return
            }
            
            guard let data = data else { return }
            // доработать
            print("LOG: success sign up \(data)")
            print("LOG: responce sign up \(response)")
            
        }.resume()
    }
    
    func getPosts() {
        
        
    }
    
    // Получить все посты связанные с пользователем по айди
    func getPostsForProfile(userId: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/wp-json/wp/v2/posts?author=\(userId)") else { return }
        
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

    // MARK: - Messages
    
    func getChatList(complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void) {
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp-json/buddypress/v1/messages") else { return }
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "GET"
        loginRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                complitionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let chatList = try JSONDecoder().decode([ChatList].self, from: data)
                complitionHandler(.success(chatList))
            } catch {
                print("LOG: ошибка chatList \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    func getMessages(id: Int, complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void) {
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp-json/buddypress/v1/messages/\(id)") else { return }
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "GET"
        loginRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                complitionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let chatList = try JSONDecoder().decode([ChatList].self, from: data)
                complitionHandler(.success(chatList))
            } catch {
                print("LOG: ошибка chatList \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    func sendMessageTo(id: Int, message: String, recipients: Int, complitionHandler: @escaping (Result<[ChatList], NetworkError>) -> Void) {
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp-json/buddypress/v1/messages") else { return }
        
        let parameters = ["id": id,
                          "message": message,
                          "recipients": recipients
        ] as [String: Any]
        
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = postData
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                complitionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let chatList = try JSONDecoder().decode([ChatList].self, from: data)
                complitionHandler(.success(chatList))
            } catch {
                print("LOG: ошибка chatList \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
}
