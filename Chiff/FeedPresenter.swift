//
//  FeedPresenter.swift
//  Chiff
//
//  Created by admin on 13.10.2021.
//

import Foundation

protocol FeedView: AnyObject {
    func presentNews(news: [News])
    func presenterUsername(username: User)
    func presentImage(image: [Media])
}

class FeedPresenter {
    
    weak var view: FeedView?
    let news: [News] = []
    
    var networkService = NetworkService()
    
    public func setViewDelegate(view: FeedView) {
        self.view = view
    }
    
    public func loadNews(page: Int) {
        networkService.getData(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.view?.presentNews(news: news)
            case .failure(let error):
                print("LOG: error for controller \(error)")
            }
        }
    }
    
    public func loadUsernameForCells(author: Int) {
        networkService.getUsernamePost(id: author) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let username):
                self.view?.presenterUsername(username: username)
            case .failure(let error):
                print("Ошибка получения имени пользователя \(error.localizedDescription)")
            }
        }
    }
    
    public func loadImageForCell(idPost: Int) {
        networkService.getImagesFromPosts(idPost: idPost) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let media):
                guard !media.isEmpty else { return }
                self.view?.presentImage(image: media)
            case .failure(let error):
                print("Ошибка получения изображения \(error.localizedDescription)")
            }
        }
    }
    
    
}

