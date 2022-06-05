//
//  CreatePostRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import UIKit

protocol CreatePostRouterProtocol: AnyObject {
    func routeToCreatePost(idPost: Int)
}

class CreatePostRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension CreatePostRouter: CreatePostRouterProtocol {
    func routeToCreatePost(idPost: Int) {
        let view = DetailFeedAssembly.create(idPost: idPost)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
