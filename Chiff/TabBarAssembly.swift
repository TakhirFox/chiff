//
//  TabBarAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import UIKit

class TabBarAssembly {
    static func create(_ index: Int?) -> UIViewController {
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        let router = TabBarRouter()
        
        let viewController = TabBarViewController(presenter: presenter)
        
        viewController.index = index
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
