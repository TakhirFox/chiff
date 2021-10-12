//
//  FeedController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit
import SwiftKeychainWrapper

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var news: [News] = []
    var auth: Auth?
    var networkService = NetworkService()
    var login: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
 
        configureUI()
        
        
        networkService.getProfileInfo { result in
            switch result {
            case .success(let user):
                print("LOG: user information \(user)")
            case .failure(let error):
                print("LOG: Проблема с входом а именно \(error)")
            }
            
        }
        
        
    }
    
    fileprivate func configureUI() {
        collectionView.backgroundColor = UIColor.gray
        collectionView.layer.cornerRadius = 20
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logoutAction))
    }
    
    @objc func logoutAction() {
        KeychainWrapper.standard.removeObject(forKey: "token")
        KeychainWrapper.standard.removeObject(forKey: "user_email")
        KeychainWrapper.standard.removeObject(forKey: "user_nicename")
        KeychainWrapper.standard.removeObject(forKey: "user_display_name")
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.label.text = auth?.user_display_name
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 400)
    }
    
    
    
}
