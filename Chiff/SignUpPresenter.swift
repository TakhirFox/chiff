//
//  SignUpPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {

}

class SignUpPresenter: BasePresenter {
    weak var view: SignUpViewControllerProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
}
