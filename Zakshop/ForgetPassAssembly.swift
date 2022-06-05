//
//  ForgetPassAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import UIKit

class ForgetPassAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = ForgetPassViewController()
        let presenter = ForgetPassPresenter()
        let interactor = ForgetPassInteractor()
        let router = ForgetPassRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
