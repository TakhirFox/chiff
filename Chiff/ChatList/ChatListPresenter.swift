//
//  ChatListChatListPresenter.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ChatListPresenterProtocol: AnyObject {
    func getChatList()
    
    func routeToMessage(id: Int)
    
    func showChatListSuccess(chatList: [ChatList])
    
    func showChatListError(_ error: String)

}

class ChatListPresenter: BasePresenter {
    weak var view: ChatListViewControllerProtocol?
    var interactor: ChatListInteractorProtocol?
    var router: ChatListRouterProtocol?
    var id: Int?
    
}

extension ChatListPresenter: ChatListPresenterProtocol {
    func getChatList() {
        interactor?.getChatList(id: id ?? 0)
    }
    
    func routeToMessage(id: Int) {
        router?.routeToMessage(id: id)
    }
    
    func showChatListSuccess(chatList: [ChatList]) {
        view?.setChatList(chatList: chatList)
    }
    
    func showChatListError(_ error: String) {
        view?.showChatListError(error)
    }
    
}
