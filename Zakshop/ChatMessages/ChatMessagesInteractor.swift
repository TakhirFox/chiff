//
//  ChatMessagesChatMessagesInteractor.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ChatMessagesInteractorProtocol {
    func getMessages(id: Int)
    func sendMessageTo(id: Int, message: String, recipients: Int)
    
}

class ChatMessagesInteractor: BaseInteractor {
    weak var presenter: ChatMessagesPresenterProtocol?
    var networkService: NetworkService?
    
}

extension ChatMessagesInteractor: ChatMessagesInteractorProtocol {
    func getMessages(id: Int) {
        networkService?.getMessages(id: id, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let messages):
                self.presenter?.showMessages(message: messages)
            case .failure(let error):
                self.presenter?.showMessageError("\(error)")
            }
        })
    }
    
    func sendMessageTo(id: Int, message: String, recipients: Int) {
        networkService?.sendMessageTo(id: id, message: message, recipients: recipients, complitionHandler: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let messages):
                self.presenter?.showMessages(message: messages)
            case .failure(let error):
                self.presenter?.showSendMessageError("\(error)")
            }
        })
    }
    
}
