//
//  PersonalSignUpViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import UIKit

protocol PersonalSignUpViewControllerProtocol: AnyObject {
    var presenter: PersonalSignUpPresenterProtocol? { get set }
    
}

class PersonalSignUpViewController: BaseViewController, PersonalSignUpViewControllerProtocol {
    
    private enum Items: Int {
        case titleItem = 0
        case firstnameItem = 1
        case lastnameItem = 2
        case numberPhoneItem = 3
        case bioItem = 4
        case saveButtonItem = 5
    }
    
    var tableView: UITableView!
    
    var presenter: PersonalSignUpPresenterProtocol?
    
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

extension PersonalSignUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = Items(rawValue: indexPath.item)
        switch items {
        case .titleItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! TitleCell
            cell.titleLabel.text = "Давай знакомиться?)"
            return cell
            
        case .firstnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Имя"
//            cell.textField.text = user?.firstname
            cell.textField.tag = 0
            cell.textField.delegate = self
            return cell
            
        case .lastnameItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Фамилия"
//            cell.textField.text = user?.firstname
            cell.textField.tag = 1
            cell.textField.delegate = self
            return cell
            
        case .numberPhoneItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "Мобильный телефон"
//            cell.textField.text = user?.lastname
            cell.textField.tag = 2
            cell.textField.delegate = self
            return cell
            
        case .bioItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditTextFieldCell
            cell.titleLabel.text = "О себе"
//            cell.textField.text = user?.lastname
            cell.textField.tag = 2
            cell.textField.delegate = self
            return cell
            
        case .saveButtonItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! EditButtonCell
            cell.actionButton.setTitle("Создать", for: .normal)
            cell.actionButton.addTarget(self, action: #selector(nextStepButtonAction), for: .touchUpInside)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
}

extension PersonalSignUpViewController: UITextFieldDelegate {
    
}

extension PersonalSignUpViewController {
    @objc func nextStepButtonAction() {
//        presenter?.routeToPersonalSignUpAction() // TODO: Не забыть передать заготовленные данные для последующей регистраии.
    }
}
