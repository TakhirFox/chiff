//
//  FeedPresenter.swift
//  Chiff
//
//  Created by admin on 13.10.2021.
//

import Foundation

protocol FeedView: AnyObject {
    func presentNews(news: [News])
}

class FeedPresenter {
    
    weak var view: FeedView?
    let news: [News] = []
    
    var networkService = NetworkService()
    
    public func setViewDelegate(view: FeedView) {
        self.view = view
    }
    
    public func loadNews(page: Int) {
        networkService.getData(page: page) { result in
            switch result {
            case .success(let news):
                self.view?.presentNews(news: news)
            case .failure(let error):
                print("LOG: error for controller \(error)")
            }
        }
        
//        networkService.getImagesFromPosts(idPost: <#T##Int#>, complitionHandler: <#T##(Result<Media, NetworkError>) -> Void#>)
    }
    
    
}

