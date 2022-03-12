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
    func animateHeader()
    func noNetwork()
}

class AuthViewController: BaseViewController, AuthViewControllerProtocol {
    
    let headerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "675604")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "log2o")
        view.contentMode = .scaleAspectFill
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
    
    let errorLoginLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .red
        view.isHidden = true
        return view
    }()
    
    let errorPasswordLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .red
        view.isHidden = true
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
    
    var activityIndicatorLocal = UIActivityIndicatorView()
    
    var heightImageSize: CGFloat = 300
    
    var presenter: AuthPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        headerImage.snp.makeConstraints { make in
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.top.equalTo(view)
//            make.bottom.bottom.equalTo(stackView.snp.top).offset(-16)
//            make.height.equalTo(view)
//        }
//
//        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn) {
//            self.view.layoutIfNeeded()
//        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        activityIndicatorLocal = UIActivityIndicatorView(style: .large)
        
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(headerImage)
        headerImage.addSubview(logoImage)
        headerImage.addSubview(activityIndicatorLocal)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(errorLoginLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(errorPasswordLabel)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(registerButton)
        stackViewHorizontal.addArrangedSubview(forgetAccountButton)
    }
    
    func setupConstraints() {
        headerImage.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.top.equalTo(view)
            make.bottom.bottom.equalTo(stackView.snp.top).offset(-16)
            make.height.equalTo(heightImageSize)
        }
        
        errorLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(2)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-10)
            make.height.equalTo(12)
        }
        
        errorPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.bottom.equalTo(loginButton.snp.top).inset(-10)
            make.height.equalTo(12)
        }
        
        logoImage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(headerImage).inset(32)
            make.centerY.equalTo(headerImage.snp.centerY)
        }
        
        activityIndicatorLocal.snp.makeConstraints { make in
            make.centerX.equalTo(headerImage.snp.centerX)
            make.bottom.equalTo(-50)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
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
        
        view.layoutIfNeeded()
    }
    
}

extension AuthViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        errorLoginLabel.isHidden = true
//        print(textField.text)
//    }
    // TODO: Потом нужно скрыть ошибки логина и пароля
   
}

extension AuthViewController {
    // TODO: Методы в презентер:
    @objc func checkTextFieldAction(_ sender: Any) {
        view.endEditing(true)
        presenter?.checkTextFieldEmpty(login: loginTextField.text,
                                       pass: passwordTextField.text)
    }
    
    @objc func routeToSignUpAction(_ sender: Any) {
        presenter?.routeToSignUpAction()
    }
    
    @objc func routeToForgetPasswordAction(_ sender: Any) {
        presenter?.routeToForgetPasswordAction()
    }
    
    // TODO: Методы вызывающие из презентера:
    func animateHeader() {
        activityIndicatorLocal.startAnimating()
        
        headerImage.snp_updateConstraints { make in
            make.height.equalTo(self.view.frame.height)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showLoginIsEmpty() {
        loginTextField.layer.borderColor = UIColor.red.cgColor
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.cornerRadius = 4
        errorLoginLabel.isHidden = false
        errorLoginLabel.text = "Введите логин"
    }
    
    func showPassIsEmpty() {
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 4
        errorPasswordLabel.isHidden = false
        errorPasswordLabel.text = "Введите пароль"
    }
    
    // Показать ошибку логина или пароля
    func showLoginOfPassError() {
        DispatchQueue.main.async {
            self.headerImage.snp_updateConstraints { make in
                make.height.equalTo(self.heightImageSize)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut) {
                self.activityIndicatorLocal.stopAnimating()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func noNetwork() {
        DispatchQueue.main.async {
            self.headerImage.snp_updateConstraints { make in
                make.height.equalTo(self.heightImageSize)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut) {
                self.activityIndicatorLocal.stopAnimating()
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
