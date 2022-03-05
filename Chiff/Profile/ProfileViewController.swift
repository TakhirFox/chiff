//
//  ProfileViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func setProfileInfo(user: User)
    func setPostsForProfile(posts: [News])
    
    func showErrorPostsForProfile(_ error: String)
    func showErrorProfileInfo(_ error: String)
}

class ProfileViewController: BaseViewController, ProfileViewControllerProtocol {
    
    var collectionView: UICollectionView!
    
    var user: User?
    var news: [News] = []
    var presenter: ProfilePresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getUsernameInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
        
        collectionView.isHidden = true
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        //        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cell2")
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return news.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ProfileHeaderCell
            cell.setupCell(user)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! FeedCell
            cell.setupCell(news[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
        } else {
            return .zero
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: view.frame.width - 32, height: 200)
        } else {
            return .init(width: view.frame.width / 2 - 22, height: 250)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            presenter?.routeToDetail(idPost: news[indexPath.item].id ?? 0)
        }
    }
    
}

extension ProfileViewController {
    func setProfileInfo(user: User) {
        DispatchQueue.main.async {
            self.user = user
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setPostsForProfile(posts: [News]) {
        DispatchQueue.main.async {
            self.news = posts
            self.collectionView.reloadData()
        }
    }
    
    func showErrorProfileInfo(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ ПРОФИЛЯ ВЬЮ: \(error)")
        }
    }
    
    func showErrorPostsForProfile(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ПОЛУЧЕКНИЯ ПОСТОВ ПРОФИЛЯ ВЬЮ: \(error)")
        }
    }
    
}
