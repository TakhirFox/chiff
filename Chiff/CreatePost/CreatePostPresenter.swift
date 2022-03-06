//
//  CreatePostPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import Foundation

protocol CreatePostPresenterProtocol: AnyObject {

}

class CreatePostPresenter: BasePresenter {
    weak var view: CreatePostViewControllerProtocol?
    var interactor: CreatePostInteractorProtocol?
    var router: CreatePostRouterProtocol?
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
    
}
