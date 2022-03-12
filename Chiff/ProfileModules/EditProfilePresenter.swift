//
//  EditProfilePresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {
    func getUsernameInfo()
    func saveChangesProfile(user: User?)
    
    func showProfileSuccess(user: User)
    func showEditProfileSuccess(user: User)
    func showProfileError(_ error: String)
    func showEditProfileError(_ error: String)
}

class EditProfilePresenter: BasePresenter {
    weak var view: EditProfileViewControllerProtocol?
    var interactor: EditProfileInteractorProtocol?
    var router: EditProfileRouterProtocol?
    var idUser: Int?
    
}

extension EditProfilePresenter: EditProfilePresenterProtocol {
    
    func getUsernameInfo() {
        interactor?.getUsernameInfo(idUser ?? 0)
    }
    
    func saveChangesProfile(user: User?) {
        // TODO: Добавить изменение аватарки и пароля
        var parameters = ""
        
        if let firstname = user?.firstname, firstname.count > 0 {
            parameters += "firstname=\(firstname)&"
        }
        
        if let lastname = user?.lastname, lastname.count > 0 {
            parameters += "lastname=\(lastname)&"
        }
        
        if let numberphone = user?.numberphone, numberphone.count > 0 {
            parameters += "numberphone=\(numberphone)&"
        }
        
        if let description = user?.welcomeDescription, description.count > 0 {
            parameters += "description=\(description)&"
        }
        
        interactor?.saveChangesProfile(idUser ?? 0, params: parameters)
    }
    
    func showProfileSuccess(user: User) {
        view?.setProfileInfo(user: user)
    }
    
    func showEditProfileSuccess(user: User) {
        view?.showEditProfileSuccess(user: user)
    }
    
    func showEditProfileError(_ error: String) {
        view?.showEditProfileError(error)
    }
    
    func showProfileError(_ error: String) {
        view?.showErrorProfileInfo(error)
    }
}
