//
//  ChatMessagesChatMessagesViewController.swift
//  Chiff
//
//  Created by Zakirov Takhir on 20/03/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatMessagesViewControllerProtocol: AnyObject {
    var presenter: ChatMessagesPresenterProtocol? { get set }
    
    func setMessages(messages: [ChatList])
    
    func showMessagesError(_ error: String)
}

class ChatMessagesViewController: BaseViewController, ChatMessagesViewControllerProtocol {
    
    let chatTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 143/255, green: 206/255, blue: 0/255, alpha: 0.5)
        view.layer.cornerRadius = 20
        
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = view.bounds
//        view.addSubview(blurredEffectView)
        
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        return view
    }()

    let sendButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 16
        view.setImage(UIImage(systemName: "paperplane"), for: .normal)
        view.backgroundColor = .init(red: 143/255, green: 206/255, blue: 0/255, alpha: 1)
        view.tintColor = .white
        view.addTarget(self, action: #selector(sendMessageAction), for: .touchUpInside)
        return view
    }()
    
    let blurEffect = UIBlurEffect(style: .dark)
    var blurredEffectView = UIVisualEffectView()
   
    var tableView: UITableView!
    
    var messageContent = String()
    var messages: [ChatList]?
    var presenter: ChatMessagesPresenterProtocol?
    let networkService = NetworkService() // TODO: Временная херня
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupSubviews()
        setupConstraints()
        registerKeyboardNotifications()
        
        chatTextFieldView.frame = view.bounds
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = chatTextFieldView.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: Временная херня
        networkService.getMessages(id: 4, complitionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let messages):
                DispatchQueue.main.async {
                    self.messages = messages
                    self.tableView.reloadData()
                    //            self.collectionView.isHidden = false
                    //            self.activityIndicator.stopAnimating()
                    self.goToBottomCell()
                }
            case .failure(let error):
                print("LOG: ОШИБКА ПОЛУЧЕНИЯ ДАННЫХ")
            }
        })
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.contentInset.bottom = 60
        tabBarController?.tabBar.isHidden = true // TODO: Красивее будет сделать анимацию смещения таббара вниз
        tableView.register(SentChatCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ReceivedChatCell.self, forCellReuseIdentifier: "cell1")
        
        textView.delegate = self
        
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(chatTextFieldView)
        view.addSubview(blurredEffectView)
        chatTextFieldView.addSubview(textView)
        chatTextFieldView.addSubview(sendButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height)
        }
        
        chatTextFieldView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(tableView).inset(26)
            make.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalTo(chatTextFieldView).inset(8)
            make.top.bottom.equalTo(chatTextFieldView).inset(4)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(chatTextFieldView).inset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.leading.equalTo(textView.snp.trailing).offset(4)
        }
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            tableView.snp.updateConstraints { make in
                make.height.equalTo(self.view.frame.height - keyboardHeight)
            }
        }
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
        
        goToBottomCell()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            tableView.snp.updateConstraints { make in
                make.height.equalTo(self.view.frame.height)
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func goToBottomCell() {
        let lastRow = self.tableView.numberOfRows(inSection: 0) - 1
        let indexPath = IndexPath(row: lastRow, section: 0);
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @objc func sendMessageAction() {
        textView.text = ""
        
        networkService.sendMessageTo(id: 4, message: messageContent, recipients: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let messages):
                DispatchQueue.main.async {
                    self.messages = messages
                    self.tableView.reloadData()
                    //            self.collectionView.isHidden = false
                    //            self.activityIndicator.stopAnimating()
                    self.goToBottomCell()
                }
            case .failure(let error):
                print("LOG: ОШИБКА ПОЛУЧЕНИЯ ДАННЫХ")
            }
        }
    }
    
}

extension ChatMessagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?[0].messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages?[0].messages?[indexPath.row].senderID == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SentChatCell
            cell.messageLabel.text = messages?[0].messages?[indexPath.row].message?.raw
            cell.dateLabel.text = "23:99"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ReceivedChatCell
            cell.messageLabel.text = messages?[0].messages?[indexPath.row].message?.raw
            cell.dateLabel.text = "23:99"
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ChatMessagesViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        messageContent = textView.text
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        print("LOG: text \(textView.text)")
//    }
    
}

extension ChatMessagesViewController {
    func setMessages(messages: [ChatList]) {
        DispatchQueue.main.async {
            self.messages = messages
            self.tableView.reloadData()
            //            self.collectionView.isHidden = false
            //            self.activityIndicator.stopAnimating()
        }
    }
    
    func showMessagesError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ СООБЩЕНИЙ ВЬЮ: \(error)")
        }
    }
    
}
