//
//  SignUpViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.02.2022.
//

import UIKit
import SnapKit

protocol SignUpViewControllerProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }
}

class SignUpViewController: BaseViewController, SignUpViewControllerProtocol {
    
    var presenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        
        
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
}

extension SignUpViewController {
   
}
