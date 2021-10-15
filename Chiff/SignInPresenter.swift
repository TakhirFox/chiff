//
//  SignInPresenter.swift
//  Chiff
//
//  Created by admin on 13.10.2021.
//

import Foundation

protocol SignInView: AnyObject {
    func presentSignIn(auth: Auth)
    func wrongLoginOrPass()
}

class SignInPresenter {
    
    weak var view: SignInView?
    
    var networkService = NetworkService()
    var auth: Auth?
    
    public func load() {
        
    }
    
    public func setViewDelegate(view: SignInView) {
        self.view = view
    }
    
    public func auth(login: String, password: String) {
        networkService.getAuth(login: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let auth):
                self.view?.presentSignIn(auth: auth)
            case .failure(let error):
                switch error {
                case .badURL:
                    print("LOG: ERROR 1")
                case .requestFailed:
                    print("LOG: ERROR 2")
                case .unknown:
                    print("LOG: ERROR 3")
                case .errorSignIn:
                    self.view?.wrongLoginOrPass()
                }
            }
        }
    }

    
}
