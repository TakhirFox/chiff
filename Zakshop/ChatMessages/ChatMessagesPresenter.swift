//
//  ChatMessagesChatMessagesPresenter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ChatMessagesPresenterProtocol: AnyObject {
    func getMessages()
    func sendMessageTo(message: String)
    
    func showMessages(message: [ChatList])
    
    func showMessageError(_ error: String)
    func showSendMessageError(_ error: String)
    
}

class ChatMessagesPresenter: BasePresenter {
    weak var view: ChatMessagesViewControllerProtocol?
    var interactor: ChatMessagesInteractorProtocol?
    var router: ChatMessagesRouterProtocol?
    var messageId: Int?
    var fromId: Int?
    var toId: Int?
    
}

extension ChatMessagesPresenter: ChatMessagesPresenterProtocol {
    func getMessages() {
        guard let messageId = messageId else { return }
        
        interactor?.getMessages(id: messageId)
    }
    
    func sendMessageTo(message: String) {
        guard let fromId = fromId,
        let toId = toId else { return }
        
        interactor?.sendMessageTo(id: fromId, message: message, recipients: toId)
    }
    
    func showMessages(message: [ChatList]) {
        view?.setMessages(messages: message)
    }
    
    func showMessageError(_ error: String) {
        view?.showGetMessageError(error)
    }
    
    func showSendMessageError(_ error: String) {
        view?.showSendMessageError(error)
    }
    
}
