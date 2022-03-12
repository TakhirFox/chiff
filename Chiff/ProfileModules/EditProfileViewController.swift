//
//  EditProfileViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.03.2022.
//

import UIKit

protocol EditProfileViewControllerProtocol: AnyObject {
    var presenter: EditProfilePresenterProtocol? { get set }
    func setProfileInfo(user: User)
    
    func showEditProfileSuccess(user: User)
    func showErrorProfileInfo(_ error: String)
    func showEditProfileError(_ error: String)
}

class EditProfileViewController: BaseViewController, EditProfileViewControllerProtocol {
    
    private enum Items: Int {
        case imageItem = 0
        case firstnameItem = 1
        case lastnameItem = 2
        case emailItem = 3
        case numberPhoneItem = 4
        case bioItem = 5
        case passwordItem = 6
        case saveButtonItem = 7
    }
    
    var tableView: UITableView!
    
    var user: User?
    var editUser = User()
    var presenter: EditProfilePresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getUsernameInfo()
    }
    
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
        tableView.register(EditAvatarCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(EditTextFieldCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(EditButtonCell.self, forCellReuseIdentifier: "cell3")
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = Items(rawValue: indexPath.item)
        switch items {
        case .imageItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! EditAvatarCell
            let urlString = URL(string: user?.avatarimage?.guid ?? "")
            cell.avatarImageView.kf.setImage(with: urlString)
            return cell
            
        case .firstnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Имя"
            cell.textField.text = user?.firstname
            cell.textField.tag = 0
            cell.textField.delegate = self
            return cell
            
        case .lastnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Фамилия"
            cell.textField.text = user?.lastname
            cell.textField.tag = 1
            cell.textField.delegate = self
            return cell
            
        case .emailItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Почта"
            cell.textField.text = user?.userEmail
            cell.textField.tag = 2
            cell.textField.keyboardType = .emailAddress
            cell.textField.delegate = self
            return cell
            
        case .numberPhoneItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Номер телефона"
            cell.textField.text = user?.numberphone
            cell.textField.tag = 3
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
            
        case .bioItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "О себе"
            cell.textField.text = user?.welcomeDescription
            cell.textField.tag = 4
            cell.textField.delegate = self
            return cell
            
        case .passwordItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Пароль"
            cell.textField.tag = 5
            cell.textField.delegate = self
            return cell
            
        case .saveButtonItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! EditButtonCell
            cell.actionButton.setTitle("Сохранить", for: .normal)
            cell.actionButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    
}

extension EditProfileViewController {
    @objc func saveButtonAction() {
        
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? EditTextFieldCell {
                let items = cell.textField.tag
                switch items {
                case 0:
                    editUser.firstname = cell.textField.text
                case 1:
                    editUser.lastname = cell.textField.text
                case 2:
                    editUser.userEmail = cell.textField.text
                case 3:
                    editUser.numberphone = cell.textField.text
                case 4:
                    editUser.welcomeDescription = cell.textField.text
                default:
                    print("LOG: none")
                }
//                items.description.forEach() { a in print("LOG: \(cell.textField.text)") }
            }
        }
        
        presenter?.saveChangesProfile(user: editUser, oldUserInfo: user)
    }
    
    func setProfileInfo(user: User) {
        DispatchQueue.main.async {
            self.user = user
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showEditProfileSuccess(user: User) {
        let alertController = UIAlertController(title: "Сохранено", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func showEditProfileError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ ПРОФИЛЯ ВЬЮ: \(error)")
        }
    }
    
    func showErrorProfileInfo(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ ПРОФИЛЯ ВЬЮ: \(error)")
        }
    }
    
}
