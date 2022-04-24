//
//  ChatMessagesChatMessagesPresenter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ChatMessagesPresenterProtocol: AnyObject {
    func getMessages(id: Int)
    func sendMessageTo(id: Int, message: String, recipients: Int)
    
    func showMessages(message: [ChatList])
    
    func showMessageError(_ error: String)
    func showSendMessageError(_ error: String)
    
}

class ChatMessagesPresenter: BasePresenter {
    weak var view: ChatMessagesViewControllerProtocol?
    var interactor: ChatMessagesInteractorProtocol?
    var router: ChatMessagesRouterProtocol?
    var id: Int?
    
}

extension ChatMessagesPresenter: ChatMessagesPresenterProtocol {
    func getMessages(id: Int) {
        interactor?.getMessages(id: id)
    }
    
    func sendMessageTo(id: Int, message: String, recipients: Int) {
        interactor?.sendMessageTo(id: id, message: message, recipients: recipients)
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
