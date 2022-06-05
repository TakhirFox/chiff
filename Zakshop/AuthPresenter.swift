//
//  AuthPresenter.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func checkTextFieldEmpty(login: String?, pass: String?)
    func routeToSignUpAction()
    func routeToForgetPasswordAction()
    func authSuccess()
    func authError()
    func noNetwork()
}

class AuthPresenter: BasePresenter {
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
}

extension AuthPresenter: AuthPresenterProtocol {
    func checkTextFieldEmpty(login: String?, pass: String?) {
        if let login = login, login == ""  {
            view?.showLoginIsEmpty()
        }
        
        if let pass = pass, pass == ""  {
            view?.showPassIsEmpty()
            
        }
        
        if let login = login, login != "", let pass = pass, pass != "" {
            view?.animateHeader()
            authAndRoute(login: login, pass: pass)
        }
    }
    
    func routeToSignUpAction() {
        router?.routeToSignUpAction()
    }
    
    func routeToForgetPasswordAction() {
        router?.routeToForgetPasswordAction()
    }
    
    private func authAndRoute(login: String, pass: String) {
        interactor?.authAndRoute(login: login, pass: pass)
    }
    
    func authSuccess() {
        router?.routeToMain()
    }
    
    func authError() {
        view?.showLoginOfPassError()
    }
    
    func noNetwork() {
        view?.noNetwork()
    }
    
}
