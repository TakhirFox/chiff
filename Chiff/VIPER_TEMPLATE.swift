//
//  VIPER_TEMPLATE.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import UIKit

// MARK: - VIEW

protocol NAME_ViewControllerProtocol: AnyObject {
    var presenter: NAME_PresenterProtocol? { get set }
}

class NAME_ViewController: BaseViewController, NAME_ViewControllerProtocol {
    
    var presenter: NAME_PresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
}

extension NAME_ViewController {
   
}


// MARK: - PRESENTER

protocol NAME_PresenterProtocol: AnyObject {

}

class NAME_Presenter: BasePresenter {
    weak var view: NAME_ViewControllerProtocol?
    var interactor: NAME_InteractorProtocol?
    var router: NAME_RouterProtocol?
}

extension NAME_Presenter: NAME_PresenterProtocol {
    
}


// MARK: - INTERACTOR

protocol NAME_InteractorProtocol {
    
}

class NAME_Interactor: BaseInteractor, NAME_InteractorProtocol {
    weak var presenter: NAME_PresenterProtocol?
}


// MARK: - ROUTER

protocol NAME_RouterProtocol: AnyObject {
    
}

class NAME_Router: BaseRouter {
    weak var viewController: UIViewController?
}

extension NAME_Router: NAME_RouterProtocol {
    
}


// MARK: - ASSEMBLY

class NAME_Assembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = NAME_ViewController()
        let presenter = NAME_Presenter()
        let interactor = NAME_Interactor()
        let router = NAME_Router()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    
}
