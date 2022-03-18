//
//  SignUpPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    func routeToPersonalSignUpAction(user: NewUser)
    
}

class SignUpPresenter: BasePresenter {
    weak var view: SignUpViewControllerProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
}

extension SignUpPresenter: SignUpPresenterProtocol {
    func routeToPersonalSignUpAction(user: NewUser) {
        if user.username == "" {
            print("LOG: НЕ ввели username")
        }
        
        if user.email == "" {
            print("LOG: НЕ ввели email")
        }
        
        if user.password == "" {
            print("LOG: НЕ ввели password")
        }
        
        if user.confirmPassword == "" {
            print("LOG: НЕ ввели confirmPassword")
        }
        
        if user.password != "", user.confirmPassword != "",
           user.password != user.confirmPassword {
            print("LOG: ПАРОЛИ НЕ СОВПОДАЮТ")
        }
        
        if user.username != "",
           user.email != "",
           user.password != "",
           user.confirmPassword != "",
           user.password == user.confirmPassword {
            // TODO: Вообще логика нормальная?
            router?.routeToPersonalSignUpAction(user: user)
        }
    }
    
}
