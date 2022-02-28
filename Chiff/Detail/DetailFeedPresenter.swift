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
    
    func showDetailPostError(_ error: String)
    func showSimilarPostError(_ error: String)
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
    
    func showDetailPostError(_ error: String) {
        view?.showDetailPostError(error)
    }
    
    func getSimilarPostSuccess(similar: [News]) {
        view?.getSimilarPostSuccess(similar: similar)
    }
    
    func showSimilarPostError(_ error: String) {
        view?.showSimilarPostError(error)
    }
    
}
