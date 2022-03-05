//
//  DetailFeedRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import UIKit

protocol DetailFeedRouterProtocol: AnyObject {
    func routeToProfile(id: Int)
    func routeToDetail(idPost: Int)
}

class DetailFeedRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension DetailFeedRouter: DetailFeedRouterProtocol {
    func routeToProfile(id: Int) {
        let view = ProfileAssembly.create(id: id)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToDetail(idPost: Int) {
        let view = DetailFeedAssembly.create(idPost: idPost)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}


