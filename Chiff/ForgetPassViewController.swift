//
//  ForgetPassViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import UIKit
import SnapKit

protocol ForgetPassViewControllerProtocol: AnyObject {
    var presenter: ForgetPassPresenterProtocol? { get set }
}

class ForgetPassViewController: BaseViewController, ForgetPassViewControllerProtocol {
    
    var presenter: ForgetPassPresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       
    }
    
    func setupConstraints() {
    
    }
}

extension ForgetPassViewController {
   
}
