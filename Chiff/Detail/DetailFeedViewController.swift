//
//  DetailFeedViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 26.02.2022.
//

import UIKit

protocol DetailFeedViewControllerProtocol: AnyObject {
    var presenter: DetailFeedPresenterProtocol? { get set }
    func setDetailPostInfo(post: News)
    func getSimilarPostSuccess(similar: [News])
    func setUsernamePost(user: User)
    
    func showDetailPostError(_ error: String)
    func showSimilarPostError(_ error: String)
    func showSUsernamePostError(_ error: String)
}

class DetailFeedViewController: BaseViewController, DetailFeedViewControllerProtocol {
    
    private enum Items: Int {
        case imageItem = 0
        case titleItem = 1
        case locationItem = 2
        case descriptionItem = 3
        case contactsItem = 4
        case infoAuthorItem = 5
        case paidAdsItem = 6
        case similarTitle = 7
    }
    
    var collectionView: UICollectionView!
    
    var news: News?
    var similarNews: [News]?
    var user: User?
    var presenter: DetailFeedPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getDetailPostInfo()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
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
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DetailImageCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(DetailNameCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(DetailDescCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: "cell6")
        collectionView.register(InfoAuthorCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(PaidAdsCell.self, forCellWithReuseIdentifier: "cell5")
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: "cell8")
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cell7")
    }
    
}

extension DetailFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return similarNews?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let items = Items(rawValue: indexPath.item)
            
            switch items {
            case .imageItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! DetailImageCell
                cell.setupCell(news)
                return cell
                
            case .titleItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DetailNameCell
                cell.setupCell(news)
                return cell
                
            case .locationItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .yellow
                return cell
                
            case .descriptionItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! DetailDescCell
                cell.setupCell(news)
                return cell
                
            case .contactsItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! ContactCell
                return cell
                
            case .infoAuthorItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! InfoAuthorCell
                cell.setupCell(user)
                return cell
                
            case .paidAdsItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! PaidAdsCell
                return cell
                
            case .similarTitle:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell8", for: indexPath) as! HeaderCell
                cell.setupCell("Похожие товары")
                return cell
                
            case .none:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .gray
                return cell
                
            }
            
        } else {

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell7", for: indexPath) as! FeedCell
                cell.setupCell(similarNews?[indexPath.row])
                return cell
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var padding: CGFloat = 0
        if indexPath.section == 0 {
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
            case .paidAdsItem:
                height = 300
                padding = 32
            case .similarTitle:
                height = 35
                padding = 32
            case .none:
                height = 100
                padding = 32
            }
            
            return .init(width: view.frame.width - padding, height: height)
        } else {
            return .init(width: (view.frame.width / 2) - 21, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let items = Items(rawValue: indexPath.item)
            
            switch items {
            case .imageItem:
                print("LOG: Увеличить изображение")
            case .titleItem:
                print("LOG: Ничего")
            case .locationItem:
                print("LOG: Возможно показать карту")
            case .descriptionItem:
                print("LOG: ХЗ. Увеличить повысоту блока для текста?")
            case .contactsItem:
                print("LOG: Скорее сделаем эддТаргет по кнопкам")
            case .infoAuthorItem:
                presenter?.routeToProfile(id: news?.author ?? 0)
            case .paidAdsItem:
                print("LOG: Переход к рекламе")
            case .similarTitle:
                print("LOG: Ничего, а может show/hide блок похожих")
            case .none:
                print("LOG: хех")
            }
        } else {
            presenter?.routeToDetail(idPost: similarNews?[indexPath.item].id ?? 0)
        }
    }
    
}

extension DetailFeedViewController {
    func setDetailPostInfo(post: News) {
        DispatchQueue.main.async {
            self.news = post
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func getSimilarPostSuccess(similar: [News]) {
        DispatchQueue.main.async {
            self.similarNews = similar
            self.collectionView.reloadData()
        }
    }
    
    func setUsernamePost(user: User) {
        DispatchQueue.main.async {
            self.user = user
            self.collectionView.reloadData()
        }
    }
    
    func showSimilarPostError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ДЕТАЛЬНЫЙ ПОСТ ПОХОЖИХ ВЬЮ: \(error)")
        }
    }
    
    func showDetailPostError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА ДЕТАЛЬНЫЙ ПОСТ ВЬЮ: \(error)")
        }
    }
    
    func showSUsernamePostError(_ error: String) {
        DispatchQueue.main.async {
            print("ОШИБКА USERNAME ПОСТ ВЬЮ: \(error)")
        }
    }
    
}
