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
    
    private enum Items: Int {
        case imageItem = 0
        case firstnameItem = 1
        case lastnameItem = 2
        case emailItem = 3
        case bioItem = 4
        case passwordItem = 5
        case saveButtonItem = 6
    }
    
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
//        tableView.isHidden = true
        tableView.register(EditAvatarCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(EditTextFieldCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(EditButtonCell.self, forCellReuseIdentifier: "cell3")
        setProfileInfo()
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = Items(rawValue: indexPath.item)
        switch items {
        case .imageItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! EditAvatarCell
            
            return cell
            
        case .firstnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Имя"
            cell.textField.delegate = self
            return cell
            
        case .lastnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Фамилия"
            cell.textField.delegate = self
            return cell
            
        case .emailItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Почта"
            cell.textField.delegate = self
            return cell
            
        case .bioItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "О себе"
            cell.textField.delegate = self
            return cell
            
        case .passwordItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Пароль"
            cell.textField.delegate = self
            return cell
            
        case .saveButtonItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! EditButtonCell
            cell.actionButton.setTitle("Сохранить", for: .normal)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("LOG: sda \(indexPath.row)")
    }

}

extension EditProfileViewController: UITextFieldDelegate {
    
}

extension EditProfileViewController {
    func setProfileInfo() {
        self.activityIndicator.stopAnimating()
    }
}
