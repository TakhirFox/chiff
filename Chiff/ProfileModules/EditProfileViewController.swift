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
    
    var tableView: UITableView!
    
    var user: User?
    var presenter: EditProfilePresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
        
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.isHidden = true
//        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
   
}

extension EditProfileViewController {
   
}
