//
//  ChatListChatListInteractor.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ChatListInteractorProtocol {
    func getChatList(id: Int)
}

class ChatListInteractor: BaseInteractor {
    weak var presenter: ChatListPresenterProtocol?
    var networkService: NetworkService?
    
}

extension ChatListInteractor: ChatListInteractorProtocol {
    func getChatList(id: Int) {
        networkService?.getChatList(complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let chatList):
                self.presenter?.showChatListSuccess(chatList: chatList)
            case .failure(let error):
                self.presenter?.showChatListError("\(error)")
            }
        })
    }
    
}
  
