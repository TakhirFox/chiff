//
//  FeedInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import Foundation

protocol FeedInteractorProtocol {
    func getPosts()
    func getCategories()
    func getFilterCategory(id: Int)
}

class FeedInteractor: BaseInteractor {
    weak var presenter: FeedPresenterProtocol?
    var networkService: NetworkService!
}

extension FeedInteractor: FeedInteractorProtocol {
    func getPosts() {
        networkService.getData(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.presenter?.getPostsSuccess(news: news)
            case .failure(let error):
                self.presenter?.getPostsError(error: "\(error)")
            }
        }
    }
    
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
    
    func getFilterCategory(id: Int) {
        networkService.getPostFromCategory(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.presenter?.showPostsFromCategorySuccess(posts: posts)
            case .failure(let error):
                self.presenter?.showPostsFromCategoryError(error: "\(error)")
            }
        }
    }
    
}
