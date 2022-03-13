//
//  PersonalSignUpPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import Foundation

protocol PersonalSignUpPresenterProtocol: AnyObject {

}

class PersonalSignUpPresenter: BasePresenter {
    weak var view: PersonalSignUpViewControllerProtocol?
    var interactor: PersonalSignUpInteractorProtocol?
    var router: PersonalSignUpRouterProtocol?
}

extension PersonalSignUpPresenter: PersonalSignUpPresenterProtocol {
    
}
