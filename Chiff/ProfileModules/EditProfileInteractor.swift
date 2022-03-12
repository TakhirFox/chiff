//
//  EditProfileInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import Foundation

protocol EditProfileInteractorProtocol {
    func getUsernameInfo(_ id: Int)
    func saveChangesProfile(_ id: Int, params: String)
}

class EditProfileInteractor: BaseInteractor, EditProfileInteractorProtocol {
    weak var presenter: EditProfilePresenterProtocol?
    var networkService: NetworkService?
    
}

extension EditProfileInteractor {
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
    
    func saveChangesProfile(_ id: Int, params: String) {
        networkService?.editProfile(userId: id, params: params, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter?.showEditProfileSuccess(user: user)
            case .failure(let error):
                self.presenter?.showEditProfileError("\(error)")
            }
        })
    }
    
}
