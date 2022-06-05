//
//  ChatMessagesChatMessagesAssembly.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ChatMessagesAssembly {
    static func create(messageId: Int, fromId: Int = 0, toId: Int = 0) -> UIViewController {
        let viewController = ChatMessagesViewController()
        let presenter = ChatMessagesPresenter()
        let interactor = ChatMessagesInteractor()
        let router = ChatMessagesRouter()
        let networkService = NetworkService()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.messageId = messageId
        presenter.fromId = fromId
        presenter.toId = toId
        
        interactor.presenter = presenter
        interactor.networkService = networkService
        
        router.viewController = viewController
        
        return viewController
    }
    
}
