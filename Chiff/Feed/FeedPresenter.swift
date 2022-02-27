//
//  FeedPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func getPosts()
    func getPostsError(error: String)
    func getPostsSuccess(news: [News])
    
    func routeToDetail(idPost: Int)
}

class FeedPresenter: BasePresenter {
    weak var view: FeedViewControllerProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedRouterProtocol?
}

extension FeedPresenter: FeedPresenterProtocol {
    func getPosts() {
        interactor?.getPosts()
    }
    
    func getPostsError(error: String) {
        view?.showError(error: error)
    }
    
    func getPostsSuccess(news: [News]) {
        view?.newsDataReload(news: news)
    }
    
    func routeToDetail(idPost: Int) {
        router?.routeToDetail(idPost: idPost)
    }
    
}
