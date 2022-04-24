//
//  ChatListChatListViewController.swift
//  Chiff
//
//  Created by Zakirov Takhir on 19/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatListViewControllerProtocol: AnyObject {
    var presenter: ChatListPresenterProtocol? { get set }

    func setChatList(chatList: [ChatList])
    
    func showChatListError(_ error: String)
}

class ChatListViewController: BaseViewController, ChatListViewControllerProtocol {
    
    var tableView: UITableView!
    
    var chatList: [ChatList]?
    var presenter: ChatListPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getChatList()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
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
        tableView.register(ChatListCell.self, forCellReuseIdentifier: "cell")
        
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatList?[0].messages?.count ?? 0
        return chatList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatListCell
//        cell.usernameLabel.text = chatList?[indexPath.row].
        cell.productNameLabel.text = chatList?[indexPath.row].subject?.rendered
        cell.messageLabel.text = chatList?[indexPath.row].excerpt?.rendered
        print("LOG: info cell \(chatList?[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fromId = chatList?[indexPath.row].id else { return }
        guard let toId = chatList?[indexPath.row].recipients else { return }
        
        presenter?.routeToMessage(fromId: fromId,
                                  toId: toId)
    }
    
}

extension ChatListViewController {
    func setChatList(chatList: [ChatList]) {
        DispatchQueue.main.async {
            self.chatList = chatList
            self.tableView.reloadData()
//            self.collectionView.isHidden = false
//            self.activityIndicator.stopAnimating()
        }
    }
    
    func showChatListError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ СПИСКА СООБЩЕНИЙ ВЬЮ: \(error)")
        }
    }
    
}
