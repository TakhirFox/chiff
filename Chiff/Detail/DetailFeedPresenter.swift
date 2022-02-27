//
//  DetailFeedPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import Foundation

protocol DetailFeedPresenterProtocol: AnyObject {
    func getDetailPostInfo()
    func getDetailPostSuccess(post: DetailNews)
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
    
    func getDetailPostSuccess(post: DetailNews) {
        view?.setDetailPostInfo(post: post)
    }
    
}
