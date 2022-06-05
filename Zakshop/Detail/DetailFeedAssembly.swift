//
//  DetailFeedAssembly.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import UIKit

class DetailFeedAssembly {
    static func create(idPost: Int) -> UIViewController {
        let viewController = DetailFeedViewController()
        let presenter = DetailFeedPresenter()
        let interactor = DetailFeedInteractor()
        let router = DetailFeedRouter()
        let networkService = NetworkService()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.idPost = idPost
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
