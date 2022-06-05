//
//  FeedRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import UIKit

protocol FeedRouterProtocol: AnyObject {
    func routeToDetail(idPost: Int)
}

class FeedRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension FeedRouter: FeedRouterProtocol {
    func routeToDetail(idPost: Int) {
        let view = DetailFeedAssembly.create(idPost: idPost)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    
}
