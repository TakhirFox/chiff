//
//  AuthPresenter.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    
}

class AuthPresenter: BasePresenter {
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
}

extension AuthPresenter: AuthPresenterProtocol {
    
}
