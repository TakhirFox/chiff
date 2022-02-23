//
//  SignInController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.11.2021.
//

import Foundation
import SwiftyGif
import UIKit
import Firebase

class SignInController: UIViewController {

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
        view.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зарегистрироваться", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return view
    }()
    
    let forgetAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Зыбыл пароль", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(forgetAccountAction), for: .touchUpInside)
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
    
    private let splashAnimationView = SplashAnimationView()
    private let presenter = SignInPresenter()
    
    override func viewDidLoad() {
        presenter.setViewDelegate(view: self)
        
        view.backgroundColor = .systemBackground
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(registerButton)
        stackViewHorizontal.addArrangedSubview(forgetAccountButton)
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginTextField.constrainHeight(constant: 40)
        passwordTextField.constrainHeight(constant: 40)
        loginButton.constrainHeight(constant: 50)
        
        view.addSubview(splashAnimationView)
        splashAnimationView.pinEdgesToSuperView()
        splashAnimationView.logoGifImageView.delegate = self
        
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        splashAnimationView.logoGifImageView.startAnimatingGif()
    }
    
}

// MARK: - UITextFieldDelegate
extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}


// MARK: - Actions
extension SignInController {
    @objc func goToApp(_ sender: Any) {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        presenter.auth(login: login, password: password)
    }
    
    // TODO: реализовать
    @objc func registerAction(_ sender: Any) {
        let alert = UIAlertController(title: "Фича не готова", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(ok)
        
//        Analytics.setDefaultEventParameters(["event_category":"Клиент?",
//                                             "Event_Action":"profile page",
//                                             "Event_Label":"email click",])
//
//        Analytics.logEvent("What", parameters: ["event_category":"Клиент?",
//                                                "Event_Action":"profile page",
//                                                "Event_Label":"email click",])
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // TODO: реализовать
    @objc func forgetAccountAction(_ sender: Any) {
        let alert = UIAlertController(title: "Фича не готова", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - SignInView
extension SignInController: SignInView {
    // Показываем ошибку, если ошиблись при наборе логина или пароля
    func wrongLoginOrPass() {
        let alert = UIAlertController(title: "Ошибка", message: "Неверно введены логин или пароль", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // Вызывается, если авторизация прошла успешно, и презентим таббар с контроллерами
    func presentSignIn(auth: Auth) {
//        DispatchQueue.main.async {
//            let mainController = MainTabBar()
//            mainController.modalPresentationStyle = .fullScreen
//            self.present(mainController, animated: true, completion: nil)
//        }
    }
    
}

// MARK: - SwiftyGifDelegate
extension SignInController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        splashAnimationView.isHidden = true
    }
}
