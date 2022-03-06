//
//  CreatePostInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import Foundation

protocol CreatePostInteractorProtocol {
    
}

class CreatePostInteractor: BaseInteractor, CreatePostInteractorProtocol {
    weak var presenter: CreatePostPresenterProtocol?
    var networkService: NetworkService?
}

extension CreatePostInteractor {
    
}
