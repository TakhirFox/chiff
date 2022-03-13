//
//  PersonalSignUpInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import Foundation

protocol PersonalSignUpInteractorProtocol {
    
}

class PersonalSignUpInteractor: BaseInteractor, PersonalSignUpInteractorProtocol {
    weak var presenter: PersonalSignUpPresenterProtocol?
}
