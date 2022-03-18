//
//  SignUpRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import UIKit

protocol SignUpRouterProtocol: AnyObject {
    func routeToPersonalSignUpAction(user: NewUser)
    
}

class SignUpRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension SignUpRouter: SignUpRouterProtocol {
    func routeToPersonalSignUpAction(user: NewUser) {
        let view = PersonalSignUpAssembly.create(user: user)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
