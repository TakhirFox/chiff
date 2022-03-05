//
//  EditProfileViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import UIKit

protocol EditProfileViewControllerProtocol: AnyObject {
    var presenter: EditProfilePresenterProtocol? { get set }
}

class EditProfileViewController: BaseViewController, EditProfileViewControllerProtocol {
    
    var presenter: EditProfilePresenterProtocol?
    
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

extension EditProfileViewController {
   
}
