//
//  ProfilePresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func getUsernameInfo()
    
    func showProfileSuccess(user: User)
    func showProfileError(_ error: String)
}

class ProfilePresenter: BasePresenter {
    weak var view: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    var id: Int?
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func getUsernameInfo() {
        interactor?.getUsernameInfo(id ?? 0)
    }
    
    func showProfileSuccess(user: User) {
        view?.setProfileInfo(user: user)
    }
    
    func showProfileError(_ error: String) {
        view?.showErrorProfileInfo(error)
    }
    
}
