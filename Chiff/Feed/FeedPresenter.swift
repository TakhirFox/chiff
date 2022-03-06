//
//  FeedPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func getPosts()
    func getCategories()
    
    func getPostsSuccess(news: [News])
    func showCategorySuccess(cat: [Categories])
    func getPostsError(error: String)
    func getCategoryError(error: String)
    
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
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func showCategorySuccess(cat: [Categories]) {
        view?.setCategories(cat: cat)
    }
    
    func getPostsSuccess(news: [News]) {
        view?.newsDataReload(news: news)
    }
    
    func getCategoryError(error: String) {
        view?.showCategoriesError(error: error)
    }
    
    func getPostsError(error: String) {
        view?.showError(error: error)
    }
    
    func routeToDetail(idPost: Int) {
        router?.routeToDetail(idPost: idPost)
    }
    
}
