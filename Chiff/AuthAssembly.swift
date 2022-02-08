//
//  AuthAssembly.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import UIKit

class AuthAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        let router = AuthRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
