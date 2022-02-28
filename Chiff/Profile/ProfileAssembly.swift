//
//  ProfileAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import UIKit

class ProfileAssembly {
    static func create(id: Int) -> UIViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let networkService = NetworkService()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.id = id
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
