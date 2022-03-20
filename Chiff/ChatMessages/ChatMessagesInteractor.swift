//
//  ChatMessagesChatMessagesInteractor.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ChatMessagesInteractorProtocol {
    
}

class ChatMessagesInteractor: BaseInteractor, ChatMessagesInteractorProtocol {
    weak var presenter: ChatMessagesPresenterProtocol?

}