//
//  ChatListChatListAssembly.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ChatListAssembly {
    static func create(id: Int) -> UIViewController {
        let viewController = ChatListViewController()
        let presenter = ChatListPresenter()
        let interactor = ChatListInteractor()
        let router = ChatListRouter()
        let networkService = NetworkService()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.fromId = id
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
