//
//  PersonalSignUpAssemby.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import UIKit

class PersonalSignUpAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = PersonalSignUpViewController()
        let presenter = PersonalSignUpPresenter()
        let interactor = PersonalSignUpInteractor()
        let router = PersonalSignUpRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
