//
//  TabBarInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import Foundation

protocol TabBarInteractorProtocol {
    func getMyProfile()
}

class TabBarInteractor: BaseInteractor, TabBarInteractorProtocol {
    weak var presenter: TabBarPresenterProtocol?
    var networkService: NetworkService?
}

extension TabBarInteractor {
    func getMyProfile() {
        networkService?.getProfileInfo(complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter?.showMyProfileSuccess(user: user)
            case .failure(let error):
                self.presenter?.showMyProfileError("\(error)")
            }
        })
    }
}
