//
//  NetworkService.swift
//  Chiff
//
//  Created by Zakirov Tahir on 10.04.2021.
//

import Foundation
import SwiftKeychainWrapper

enum Endpoints {
    // case
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown, errorSignIn
}

protocol NetworkServiceProtocol {
    func getData(page: Int, complitionHandler: @escaping (Result<[News], Error>) -> Void)
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
    
    // Запрашиваем изображения для постов
    func getImagesFromPosts(idPost: Int, complitionHandler: @escaping (Result<Media, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/media/\(idPost)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else { return }
            
            do {
                let media = try JSONDecoder().decode(Media.self, from: data)
                complitionHandler(.success(media))
            } catch {
                print("Не удалось загрузить картинки \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
    // Информация о пользователе
    func getProfileInfo(complitionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        
        guard let accessToken: String = KeychainWrapper.standard.string(forKey: "token") else { return }
        
        guard let url = URL(string: "\(baseUrl)/wp/v2/users/1") else { return }
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "GET"
        loginRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                     
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
                complitionHandler(.failure(error as! NetworkError))
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
