//
//  SignUpRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import UIKit

protocol SignUpRouterProtocol: AnyObject {
    func routeToPersonalSignUpAction()
    
}

class SignUpRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension SignUpRouter: SignUpRouterProtocol {
    func routeToPersonalSignUpAction() {
        let view = PersonalSignUpAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
