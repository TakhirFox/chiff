//
//  EditProfileAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import UIKit

class EditProfileAssembly {
    static func create(idUser: Int) -> UIViewController {
        let viewController = EditProfileViewController()
        let presenter = EditProfilePresenter()
        let interactor = EditProfileInteractor()
        let router = EditProfileRouter()
        let networkService = NetworkService()

        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.idUser = idUser
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
