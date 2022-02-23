//
//  AuthInteractor.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import Foundation

protocol AuthInteractorProtocol {
    func authAndRoute(login: String, pass: String)
}

class AuthInteractor: BaseInteractor, AuthInteractorProtocol {
    weak var presenter: AuthPresenterProtocol?
    var networkService: NetworkService!
    
    func authAndRoute(login: String, pass: String) {
        networkService.getAuth(login: login, password: pass) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let auth):
                self.presenter?.authSuccess()
            case .failure(let error):
                switch error {
                case .badURL:
                    print("LOG: ERROR 1")
                case .requestFailed:
                    print("LOG: ERROR 2")
                case .unknown:
                    print("LOG: ERROR 3")
                case .errorSignIn:
                    self.presenter?.authError()
                }
            }
        }
    }
}
