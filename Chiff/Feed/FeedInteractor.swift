//
//  FeedInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import Foundation

protocol FeedInteractorProtocol {
    func getPosts()
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
    
}
