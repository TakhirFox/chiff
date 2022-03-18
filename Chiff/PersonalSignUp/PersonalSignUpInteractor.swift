//
//  PersonalSignUpInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import Foundation

protocol PersonalSignUpInteractorProtocol {
    func signUpAndRoute(user: NewUser)
    
}

class PersonalSignUpInteractor: BaseInteractor, PersonalSignUpInteractorProtocol {
    weak var presenter: PersonalSignUpPresenterProtocol?
    var networkSerive: NetworkService!
    
    func signUpAndRoute(user: NewUser) {
//        networkSerive.getRegister()
        print("LOG: ЗАГЕРАЛИСЬ, УРА \(user)")
    }
    
}
