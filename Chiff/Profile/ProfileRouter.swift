//
//  ProfileRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    
}

class ProfileRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension ProfileRouter: ProfileRouterProtocol {
    
}
