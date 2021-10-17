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
    var news: [News]?
    var auth: Auth?
    var networkService = NetworkService()
    
    private let presenter = FeedPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        presenter.setViewDelegate(view: self)
        
        configureUI()
        
        print("LOG: COUNT \(news?.count)")
        
        networkService.getProfileInfo { result in
            switch result {
            case .success(let user):
                print("LOG: user information \(user)")
            case .failure(let error):
                print("LOG: Проблема с входом а именно \(error)")
            }
            
        }
        
        networkService.getData { result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self.news = news
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("LOG: error for controller \(error)")
            }
        }
        
        
    }
    
    fileprivate func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
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

        // Переход на другой экран, если все отлично
        // Код с переходом
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        
        cell.label.text = news?[indexPath.row].slug
        print("LOG: test tets \(news?[indexPath.row].slug)")
        cell.imageView.image = UIImage(named: "masterdomIcon")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 400)
    }
    

}


// Тут типо реализуем методы из презентера
extension FeedController: FeedView {
    func someFuncForNetworking() {
        // Тут реализую методы, когда вызову их из презентера
    }
    
    
}
