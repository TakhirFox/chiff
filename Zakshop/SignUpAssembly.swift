//
//  SignUpAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import UIKit

class SignUpAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = SignUpViewController()
        let presenter = SignUpPresenter()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
