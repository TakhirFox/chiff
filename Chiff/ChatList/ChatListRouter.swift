//
//  ChatListChatListRouter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatListRouterProtocol: AnyObject {
    func routeToMessage(id: Int)
    
}

class ChatListRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ChatListRouter: ChatListRouterProtocol {
    func routeToMessage(id: Int) {
        let view = ChatMessagesAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
