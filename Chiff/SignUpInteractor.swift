//
//  SignUpInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import Foundation

protocol SignUpInteractorProtocol {
    
}

class SignUpInteractor: BaseInteractor, SignUpInteractorProtocol {
    weak var presenter: SignUpPresenterProtocol?
}
