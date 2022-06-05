//
//  ChatListChatListPresenter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ChatListPresenterProtocol: AnyObject {
    func getChatList()
    
    func routeToMessage(messageId: Int, fromId: Int, toId: Int)
    
    func showChatListSuccess(chatList: [ChatList])
    
    func showChatListError(_ error: String)

}

class ChatListPresenter: BasePresenter {
    weak var view: ChatListViewControllerProtocol?
    var interactor: ChatListInteractorProtocol?
    var router: ChatListRouterProtocol?
    var fromId: Int?
    var toId: Int?
}

extension ChatListPresenter: ChatListPresenterProtocol {
    func getChatList() {
        guard let fromId = fromId else { return }
        interactor?.getChatList(id: fromId)
    }
    
    func routeToMessage(messageId: Int, fromId: Int, toId: Int) {
        router?.routeToMessage(messageId: messageId, fromId: fromId, toId: toId)
    }
    
    func showChatListSuccess(chatList: [ChatList]) {
        view?.setChatList(chatList: chatList)
    }
    
    func showChatListError(_ error: String) {
        view?.showChatListError(error)
    }
    
}
