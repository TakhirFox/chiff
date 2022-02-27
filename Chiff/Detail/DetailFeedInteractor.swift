//
//  DetailFeedInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import Foundation

protocol DetailFeedInteractorProtocol {
    func getDetailPostInfo(_ id: Int)
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
            case .failure(let error):
                print("ERROR")
            }
        })
    }
    
}
