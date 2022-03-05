//
//  TabBarPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject {
    func getMyUsernameInfo()
    
    func showMyProfileSuccess(user: User)
    func showMyProfileError(_ error: String)
}

class TabBarPresenter: BasePresenter {
    weak var view: TabBarViewControllerProtocol?
    var interactor: TabBarInteractorProtocol?
    var router: TabBarRouterProtocol?
}

extension TabBarPresenter: TabBarPresenterProtocol {
    func getMyUsernameInfo() {
        interactor?.getMyProfile()
    }
    
    func showMyProfileSuccess(user: User) {
        view?.setMyProfileInfo(user: user)
    }
    
    func showMyProfileError(_ error: String) {
        view?.showMyErrorProfileInfo(error)
    }
}
