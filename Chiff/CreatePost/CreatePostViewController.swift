//
//  CreatePostViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import UIKit

protocol CreatePostViewControllerProtocol: AnyObject {
    var presenter: CreatePostPresenterProtocol? { get set }
}

class CreatePostViewController: BaseViewController, CreatePostViewControllerProtocol {
    
    var presenter: CreatePostPresenterProtocol?
    
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

extension CreatePostViewController {
   
}
