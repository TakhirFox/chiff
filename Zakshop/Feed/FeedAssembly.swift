//
//  FeedAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import UIKit

class FeedAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = FeedViewController()
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        let router = FeedRouter()
        
        let networkService = NetworkService()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
