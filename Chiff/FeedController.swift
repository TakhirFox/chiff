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
    var currentPage = 1
    var isLoadedPage: Bool = false
    
    var news = [News]()
    var auth: Auth?
    var networkService = NetworkService()
    
    private let presenter = FeedPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        presenter.setViewDelegate(view: self)
        presenter.loadNews(page: currentPage)
        
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

        // Переход на экран логина, если вышел
        // TODO: Под вопросом если честно.
        let authViewController = UIStoryboard(name: "Main",
                                              bundle: nil)
            .instantiateViewController(withIdentifier: "SignInController") as! SignInController
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated:true, completion:nil)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        let news = news[indexPath.row]
        
        cell.titleLabel.text = news.title?.rendered
        cell.authorLabel.text = nil
        cell.imageView.image = UIImage(named: "no_image")
        
        networkService.getImagesFromPosts(idPost: news.featuredMedia ?? 0) { result in
            switch result {
            case .success(let media):
                
                DispatchQueue.global().async {
                    guard let imageUrl = URL(string: media.guid?.rendered ?? "") else { return }
                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: imageData)
                    }
                }
                
            case .failure(let error):
                print("Ошибка \(error.localizedDescription)")
            }
        }
        
        networkService.getUsernamePost(id: news.author ?? 0) { result in
            switch result {
            case .success(let username):
                
                DispatchQueue.main.async {
                    cell.authorLabel.text = username.name
                }
                
            case .failure(let error):
                print("Ошибка \(error.localizedDescription)")
            }
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 2) - 16, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let count = news.count
        
        if indexPath.item == count - 1 {
            print("current page = \(currentPage)")
            self.isLoadedPage = true
            presenter.loadNews(page: currentPage)
            currentPage += 1
        }
        
        self.isLoadedPage = false
    }
    

}


// Тут типо реализуем методы из презентера
extension FeedController: FeedView {
    func presentNews(news: [News]) {
        DispatchQueue.main.async {
            self.news += news
            self.collectionView.reloadData()
        }
    }
    
    
}
