//
//  ChatMessagesChatMessagesAssembly.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ChatMessagesAssembly {
    static func create(id: Int) -> UIViewController {
        let viewController = ChatMessagesViewController()
        let presenter = ChatMessagesPresenter()
        let interactor = ChatMessagesInteractor()
        let router = ChatMessagesRouter()
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
