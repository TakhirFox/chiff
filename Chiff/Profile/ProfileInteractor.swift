//
//  ProfileInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import Foundation

protocol ProfileInteractorProtocol {
    func getUsernameInfo(_ id: Int)
}

class ProfileInteractor: BaseInteractor {
    weak var presenter: ProfilePresenterProtocol?
    var networkService: NetworkService?
}

extension ProfileInteractor: ProfileInteractorProtocol {
    func getUsernameInfo(_ id: Int) {
        networkService?.getUsernamePost(id: id, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter?.showProfileSuccess(user: user)
            case .failure(let error):
                self.presenter?.showProfileError("\(error)")
            }
        })
    }
    
}
