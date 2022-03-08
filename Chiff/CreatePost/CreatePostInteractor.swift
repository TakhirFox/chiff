//
//  CreatePostInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import Foundation

protocol CreatePostInteractorProtocol {
    func getCategories()
    func createPost(post: CreatePostModel)
    
}

class CreatePostInteractor: BaseInteractor, CreatePostInteractorProtocol {
    weak var presenter: CreatePostPresenterProtocol?
    var networkService: NetworkService!
    
}

extension CreatePostInteractor {
    func getCategories() {
        networkService.getCategories { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let categories):
                self.presenter?.showCategorySuccess(cat: categories)
            case .failure(let error):
                self.presenter?.getCategoryError(error: "\(error)")
            }
        }
    }
    
    func createPost(post: CreatePostModel) {
        networkService!.createNewPost(post: post, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let createdPost):
                self.presenter?.showCreatePostSuccess(post: createdPost)
            case .failure(let error):
                self.presenter?.showCreatePostError("\(error)")
            }
        })
    }
    
}
