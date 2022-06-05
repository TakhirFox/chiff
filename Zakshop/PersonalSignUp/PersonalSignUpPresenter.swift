//
//  PersonalSignUpPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import Foundation

protocol PersonalSignUpPresenterProtocol: AnyObject {
    func createUsername(user: NewUser?)
    
}

class PersonalSignUpPresenter: BasePresenter {
    weak var view: PersonalSignUpViewControllerProtocol?
    var interactor: PersonalSignUpInteractorProtocol?
    var router: PersonalSignUpRouterProtocol?
    
}

extension PersonalSignUpPresenter: PersonalSignUpPresenterProtocol {
    func createUsername(user: NewUser?) {
        if let firstname = user?.firstname, firstname == "" {
            print("LOG: НЕ ввели firstname")
        }
        
        if let lastname = user?.lastname, lastname == "" {
            print("LOG: НЕ ввели firstname")
        }
        
        if let numberphone = user?.numberphone, numberphone == "" {
            print("LOG: НЕ ввели firstname")
        }
        
//        if let userBio = user?.userBio, userBio == "" {
//            print("LOG: НЕ ввели firstname")
//        }
        
        if let firstname = user?.firstname, firstname != "",
           let lastname = user?.lastname, lastname != "",
           let numberphone = user?.numberphone, numberphone != "" {
            print("LOG: РЕГИСТРАЦИЯ")
            signUpAndRoute(user: user!)
        }
           
        
        
    }
    
    private func signUpAndRoute(user: NewUser) {
        interactor?.signUpAndRoute(user: user)
    }
    
}
