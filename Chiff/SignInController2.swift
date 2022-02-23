//
//  SignInController.swift
//  Chiff
//
//  Created by admin on 12.10.2021.
//

import UIKit
import SwiftyGif

class SignInController2: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    let splashAnimationView = SplashAnimationView()
    
    private let presenter = SignInPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 8
        
        presenter.setViewDelegate(view: self)
        
        view.addSubview(splashAnimationView)
        splashAnimationView.pinEdgesToSuperView()
        splashAnimationView.logoGifImageView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        splashAnimationView.logoGifImageView.startAnimatingGif()
        }
    
    @IBAction func goToApp(_ sender: Any) {
        loginTextField.text = "winzero"
        passwordTextField.text = "zasazasa"
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        
        presenter.auth(login: login, password: password)

    }
    
}


extension SignInController2: SignInView {
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

        
        DispatchQueue.main.async {
//            let mainController = MainTabBar()
//            mainController.modalPresentationStyle = .fullScreen
//            self.present(mainController, animated: true, completion: nil)
        }
        

    }
    
}

// MARK: - SwiftyGifDelegate
extension SignInController2: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        splashAnimationView.isHidden = true
    }
}
