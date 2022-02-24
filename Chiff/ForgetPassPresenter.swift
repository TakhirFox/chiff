//
//  ForgetPassPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import Foundation

protocol ForgetPassPresenterProtocol: AnyObject {

}

class ForgetPassPresenter: BasePresenter {
    weak var view: ForgetPassViewControllerProtocol?
    var interactor: ForgetPassInteractorProtocol?
    var router: ForgetPassRouterProtocol?
}

extension ForgetPassPresenter: ForgetPassPresenterProtocol {
    
}
