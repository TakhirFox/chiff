//
//  ChatMessagesChatMessagesAssembly.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

class ChatMessagesAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = ChatMessagesViewController()
        let presenter = ChatMessagesPresenter()
        let interactor = ChatMessagesInteractor()
        let router = ChatMessagesRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}