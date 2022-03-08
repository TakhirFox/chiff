//
//  CreatePostPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import Foundation

protocol CreatePostPresenterProtocol: AnyObject {
    func getCategories()
    func checkTextFieldEmpty(post: CreatePostModel?)
    func showCategorySuccess(cat: [Categories])
    func showCreatePostSuccess(post: Int)
    func showCreatePostError(_ error: String)
    func getCategoryError(error: String)
    
    func routeToCreatePost(idPost: Int)
}

class CreatePostPresenter: BasePresenter {
    weak var view: CreatePostViewControllerProtocol?
    var interactor: CreatePostInteractorProtocol?
    var router: CreatePostRouterProtocol?
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func checkTextFieldEmpty(post: CreatePostModel?) {
        if post?.title == nil {
            view?.showTitleIsEmpty()
        }
        
        if post?.category == nil {
            view?.showCategoryIsEmpty()
        }
        
        if post?.cost == nil {
            view?.showCostIsEmpty()
        }
        
        if post?.description == nil {
            view?.showDescriptionIsEmpty()
        }
        
        if post?.title != nil, post?.category != nil, post?.cost != nil, post?.description != nil {
            view?.showStartLoadAnimating()
            interactor?.createPost(post: post!)
        }
        
    }
    
    func showCategorySuccess(cat: [Categories]) {
        view?.setCategories(cat: cat)
    }
    
    func showCreatePostSuccess(post: Int) {
        view?.showCreatePostSuccess(post)
    }
    
    func showCreatePostError(_ error: String) {
        view?.showCreatePostError(error)
    }
    
    func getCategoryError(error: String) {
        view?.showCategoriesError(error: error)
    }
    
    func routeToCreatePost(idPost: Int) {
        router?.routeToCreatePost(idPost: idPost)
    }
    
}
