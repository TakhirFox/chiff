//
//  DetailFeedInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import Foundation

protocol DetailFeedInteractorProtocol {
    func getDetailPostInfo(_ id: Int)
    func getSimilarPosts(_ id: Int)
    func getUserPost(_ userId: Int)
}

class DetailFeedInteractor: BaseInteractor {
    weak var presenter: DetailFeedPresenterProtocol?
    var networkService: NetworkService?
}

extension DetailFeedInteractor: DetailFeedInteractorProtocol {
    func getDetailPostInfo(_ id: Int) {
        networkService?.getPost(idPost: id, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.presenter?.getDetailPostSuccess(post: news)
                
                self.getUserPost(news.author!)
                self.getSimilarPosts(news.id!)
            case .failure(let error):
                self.presenter?.showDetailPostError("\(error)")
            }
        })
    }
    
    func getSimilarPosts(_ id: Int) {
        networkService?.getSimilarPost(idPost: id, complitionHandler: { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let similarPost):
                self.presenter?.getSimilarPostSuccess(similar: similarPost)
            case .failure(let error):
                self.presenter?.showSimilarPostError("\(error)")
            }
        })
    }
    
    func getUserPost(_ userId: Int) {
        networkService?.getUsernamePost(id: userId, complitionHandler: { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter?.showUsernamePostSuccess(user: user)
            case .failure(let error):
                self.presenter?.showUsernamePostError("\(error)")
            }
        })
    }
    
}
