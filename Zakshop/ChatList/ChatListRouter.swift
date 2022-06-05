//
//  ChatListChatListRouter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatListRouterProtocol: AnyObject {
    func routeToMessage(messageId: Int, fromId: Int, toId: Int)
    
}

class ChatListRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ChatListRouter: ChatListRouterProtocol {
    func routeToMessage(messageId: Int, fromId: Int, toId: Int) {
        let view = ChatMessagesAssembly.create(messageId: messageId, fromId: fromId, toId: toId)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
