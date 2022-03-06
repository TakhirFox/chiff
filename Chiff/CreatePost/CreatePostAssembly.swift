//
//  CreatePostAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import UIKit

class CreatePostAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = CreatePostViewController()
        let presenter = CreatePostPresenter()
        let interactor = CreatePostInteractor()
        let router = CreatePostRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
