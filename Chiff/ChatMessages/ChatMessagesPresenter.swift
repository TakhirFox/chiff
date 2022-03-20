//
//  ChatMessagesChatMessagesPresenter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ChatMessagesPresenterProtocol: AnyObject {

}

class ChatMessagesPresenter: BasePresenter {
    weak var view: ChatMessagesViewControllerProtocol?
    var interactor: ChatMessagesInteractorProtocol?
    var router: ChatMessagesRouterProtocol?
    
}

extension ChatMessagesPresenter: ChatMessagesPresenterProtocol {
    
}
