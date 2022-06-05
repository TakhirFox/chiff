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
    
    private enum Items: Int {
        case titleItem = 0
        case username = 1
        case emailItem = 2
        case passwordItem = 3
        case repeatPassItem = 4
        case nextStepItem = 5
    }
    
    var tableView: UITableView!
    
    var newUser = NewUser()
    var presenter: SignUpPresenterProtocol?
    
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.isHidden = true
        tableView.register(TitleCell.self, forCellReuseIdentifier: "cell0")
        tableView.register(EditAvatarCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(EditTextFieldCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(EditButtonCell.self, forCellReuseIdentifier: "cell3")
        
        tableView.isHidden = false
        activityIndicator.stopAnimating()
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

extension SignUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = Items(rawValue: indexPath.item)
        switch items {
        case .titleItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! TitleCell
            cell.titleLabel.text = "Создаем аккаунт"
            return cell
            
        case .username:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Username"
            cell.textField.tag = 0
            cell.textField.delegate = self
            return cell
            
        case .emailItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Email"
            cell.textField.tag = 1
            cell.textField.delegate = self
            return cell
            
        case .passwordItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Пароль"
            cell.textField.tag = 2
            cell.textField.delegate = self
            return cell
            
        case .repeatPassItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Повторите пароль"
            cell.textField.tag = 3
            cell.textField.delegate = self
            return cell
            
            
        case .nextStepItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! EditButtonCell
            cell.actionButton.setTitle("Далее", for: .normal)
            cell.actionButton.addTarget(self, action: #selector(nextStepButtonAction), for: .touchUpInside)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
}

extension SignUpViewController {
    @objc func nextStepButtonAction() {
        
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? EditTextFieldCell {
                let items = cell.textField.tag
                switch items {
                case 0:
                    newUser.username = cell.textField.text
                case 1:
                    newUser.email = cell.textField.text
                case 2:
                    newUser.password = cell.textField.text
                case 3:
                    newUser.confirmPassword = cell.textField.text
                default:
                    print("LOG: none")
                }
            }
        }
        
        presenter?.routeToPersonalSignUpAction(user: newUser)
    }
    
}
