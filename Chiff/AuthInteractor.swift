//
//  AuthInteractor.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import Foundation

protocol AuthInteractorProtocol {
    
}

class AuthInteractor: BaseInteractor, AuthInteractorProtocol {
    weak var presenter: AuthPresenterProtocol?
}
