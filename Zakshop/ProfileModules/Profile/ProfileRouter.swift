//
//  ProfileRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func routeToDetail(idPost: Int)
    func routeToEditProfile(idUser: Int)
}

class ProfileRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension ProfileRouter: ProfileRouterProtocol {
    func routeToDetail(idPost: Int) {
        let view = DetailFeedAssembly.create(idPost: idPost)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToEditProfile(idUser: Int) {
        let view = EditProfileAssembly.create(idUser: idUser)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
