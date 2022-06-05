//
//  AuthRouter.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    func routeToSignUpAction()
    func routeToForgetPasswordAction()
    func routeToMain()
}

class AuthRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension AuthRouter: AuthRouterProtocol {
    func routeToSignUpAction() {
        let view = SignUpAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToForgetPasswordAction() {
        let view = ForgetPassAssembly.create()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToMain() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let mainController = TabBarAssembly.create(0)
            mainController.modalPresentationStyle = .fullScreen
            self.viewController?.present(mainController, animated: true, completion: nil)
        }
    }
    
    
}


