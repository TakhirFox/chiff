//
//  DetailFeedPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import Foundation

protocol DetailFeedPresenterProtocol: AnyObject {
    func getDetailPostInfo()
    func getDetailPostSuccess(post: News)
    func getSimilarPostSuccess(similar: [News])
    func showUsernamePostSuccess(user: User)
    
    func routeToProfile(id: Int)
    func routeToDetail(idPost: Int)
    func routeToChat()
    
    func showDetailPostError(_ error: String)
    func showSimilarPostError(_ error: String)
    func showUsernamePostError(_ error: String)
    
}

class DetailFeedPresenter: BasePresenter {
    weak var view: DetailFeedViewControllerProtocol?
    var interactor: DetailFeedInteractorProtocol?
    var router: DetailFeedRouterProtocol?
    var idPost: Int?
    
}

extension DetailFeedPresenter: DetailFeedPresenterProtocol {
    func getDetailPostInfo() {
        interactor?.getDetailPostInfo(idPost!)
    }
    
    func getDetailPostSuccess(post: News) {
        view?.setDetailPostInfo(post: post)
    }
    
    func routeToProfile(id: Int) {
        router?.routeToProfile(id: id)
    }
    
    func routeToDetail(idPost: Int) {
        router?.routeToDetail(idPost: idPost)
    }
    
    func routeToChat() {
        router?.routeToChat()
    }
    
    func getSimilarPostSuccess(similar: [News]) {
        view?.getSimilarPostSuccess(similar: similar)
    }
    
    func showUsernamePostSuccess(user: User) {
        view?.setUsernamePost(user: user)
    }
    
    func showDetailPostError(_ error: String) {
        view?.showDetailPostError(error)
    }
    
    func showSimilarPostError(_ error: String) {
        view?.showSimilarPostError(error)
    }
    
    func showUsernamePostError(_ error: String) {
        view?.showSUsernamePostError(error)
    }
    
}
