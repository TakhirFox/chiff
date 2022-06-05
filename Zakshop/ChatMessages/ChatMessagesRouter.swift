//
//  ChatMessagesChatMessagesRouter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatMessagesRouterProtocol: AnyObject {
    
}

class ChatMessagesRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ChatMessagesRouter: ChatMessagesRouterProtocol {
    
}