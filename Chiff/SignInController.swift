//
//  SignInController.swift
//  Chiff
//
//  Created by admin on 12.10.2021.
//

import UIKit

class SignInController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var networkService = NetworkService()
    var auth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 8
        
        
    }
    
    @IBAction func goToApp(_ sender: Any) {
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        
        
        networkService.getAuth(login: login, password: password) { result in
            
            switch result {
            case .success(let auth):
                DispatchQueue.main.async {
                    self.auth = auth
                }
            case .failure(let error):
                switch error {
                case .badURL:
                    print("LOG: ERROR 1")
                case .requestFailed:
                    print("LOG: ERROR 2")
                case .unknown:
                    print("LOG: ERROR 3")
                case .errorSignIn:
                    print("LOG: ERROR SIGN IN")
                }
            }
              
        }
        
    }
    
}
