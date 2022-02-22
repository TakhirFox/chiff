//
//  AuthViewController.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import UIKit

protocol AuthViewControllerProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
}

class AuthViewController: BaseViewController, AuthViewControllerProtocol {
    
    let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        return view
    }()
    
    let loginTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Login"
        view.borderStyle = .roundedRect
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()
    
    let loginButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemGreen
        view.setTitle("Войти", for: .normal)
//        view.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
//        view.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return view
    }()
    
    let forgetAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зыбыл пароль", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
//        view.addTarget(self, action: #selector(forgetAccountAction), for: .touchUpInside)
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    let stackViewHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 16
        return view
    }()
    
    var presenter: AuthPresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
}
