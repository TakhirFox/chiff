//
//  EditProfilePresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {

}

class EditProfilePresenter: BasePresenter {
    weak var view: EditProfileViewControllerProtocol?
    var interactor: EditProfileInteractorProtocol?
    var router: EditProfileRouterProtocol?
}

extension EditProfilePresenter: EditProfilePresenterProtocol {
    
}
