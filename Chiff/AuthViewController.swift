//
//  AuthViewController.swift
//  Chiff
//
//  Created by admin on 08.02.2022.
//

import UIKit
import SnapKit

protocol AuthViewControllerProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    func showLoginIsEmpty()
    func showPassIsEmpty()
    func showLoginOfPassError()
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
        view.addTarget(self, action: #selector(checkTextFieldAction), for: .touchUpInside)
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(routeToSignUpAction), for: .touchUpInside)
        return view
    }()
    
    let forgetAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зыбыл пароль", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(routeToForgetPasswordAction), for: .touchUpInside)
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
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(registerButton)
        stackViewHorizontal.addArrangedSubview(forgetAccountButton)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.centerY.lessThanOrEqualToSuperview()
        }
        
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
}

extension AuthViewController {
    // TODO: Методы в презентер:
    // Проверить полноту текстовых полей (сперва проверяем полноту!!!)
    @objc func checkTextFieldAction(_ sender: Any) {
        presenter?.checkTextFieldEmpty(login: loginTextField.text,
                                       pass: passwordTextField.text)
    }
    
    // Переход на экран Регистрации
    @objc func routeToSignUpAction(_ sender: Any) {
        presenter?.routeToSignUpAction()
    }
    
    // Переход на экран Забыл пароль
    @objc func routeToForgetPasswordAction(_ sender: Any) {
        presenter?.routeToForgetPasswordAction()
    }
    
    // TODO: Методы вызывающие из презентера:
    // Показать ошибку пустых полей (возможно логин и пароль)
    func showLoginIsEmpty() {
        print("ПУСТОЙ ЛОГИН")
    }
    
    func showPassIsEmpty() {
        print("ПУСТОЙ ПАРОЛЬ")
    }
    
    // Показать ошибку логина или пароля
    func showLoginOfPassError() {
        print("НЕПРАВИЛЬНЫЙ ЛОГИН ИЛИ ПАРОЛЬ")
    }
}
