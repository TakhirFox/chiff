//
//  DetailFeedViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import UIKit

protocol DetailFeedViewControllerProtocol: AnyObject {
    var presenter: DetailFeedPresenterProtocol? { get set }
    func setDetailPostInfo(post: DetailNews)
}

class DetailFeedViewController: BaseViewController, DetailFeedViewControllerProtocol {
    
    private enum Items: Int {
        case imageItem = 0
        case titleItem = 1
        case locationItem = 2
        case descriptionItem = 3
        case contactsItem = 4
        case infoAuthorItem = 5
        case similarAdsItem = 6
        case paidAdsItem = 7
    }
    
    var collectionView: UICollectionView!
    
    var news: DetailNews?
    var presenter: DetailFeedPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getDetailPostInfo()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupTableView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DetailImageCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(DetailNameCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(DetailDescCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: "cell6")
        collectionView.register(InfoAuthorCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(PaidAdsCell.self, forCellWithReuseIdentifier: "cell5")
        
//        collectionView.separatorStyle = .none
    }
}

extension DetailFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! DetailImageCell
       
//            networkService.getImagesFromPosts(idPost: news.id ?? 0) { result in
//                switch result {
//                case .success(let media):
//
//                    DispatchQueue.main.async {
//                        cell.images = media
//                        cell.collectionView.reloadData()
//                    }
//
//                case .failure(let error):
//                    print("Ошибка получения изображения \(error.localizedDescription)")
//                }
//            }
            
            return cell
        case .titleItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DetailNameCell
            cell.titleLabel.text = news?.title?.rendered
            cell.costLabel.text = "\(news?.cost ?? "") ₽"
            return cell
        case .locationItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .yellow
            return cell
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! DetailDescCell
            cell.descriptionLabel.text = news?.content?.rendered
            return cell
        case .contactsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! ContactCell
            return cell
        case .infoAuthorItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! InfoAuthorCell
            
//            networkService.getUsernamePost(id: news.author ?? 0) { result in
//                switch result {
//                case .success(let username):
//
//                    DispatchQueue.main.async {
//                        cell.nameLabel.text = username.name
//                    }
//
//                case .failure(let error):
//                    print("Ошибка получения информации о пользователе \(error.localizedDescription)")
//                }
//            }
            
            cell.avatarImage.image = UIImage(named: "ads")
            cell.rateLabel.text = "5 отзывов"
            cell.personLabel.text = "Частое лицо"
            
            
            return cell
        case .similarAdsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .brown
            return cell
        case .paidAdsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! PaidAdsCell
            return cell
        case .none:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .gray
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var padding: CGFloat = 0
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .imageItem:
            height = 300
            padding = 0
        case .titleItem:
            height = 50
            padding = 32
        case .locationItem:
            height = 50
            padding = 32
        case .descriptionItem:
            height = 200
            padding = 32
        case .contactsItem:
            height = 40
            padding = 32
        case .infoAuthorItem:
            height = 100
            padding = 32
        case .similarAdsItem:
            height = 400
            padding = 32
        case .paidAdsItem:
            height = 300
            padding = 32
        case .none:
            height = 100
            padding = 32
        }
        
        return .init(width: view.frame.width - padding, height: height)
    }
   
}

extension DetailFeedViewController {
    func setDetailPostInfo(post: DetailNews) {
        DispatchQueue.main.async {
            self.news = post
            self.collectionView.reloadData()
        }
    }
    
}
