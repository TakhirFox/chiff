//
//  FeedViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.02.2022.
//

import UIKit
import SwiftKeychainWrapper
import Kingfisher

protocol FeedViewControllerProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    func newsDataReload(news: [News])
    func setCategories(cat: [Categories])
    func setPostsFromCategory(posts: [News])
    
    func showCategoriesError(error: String)
    func showError(error: String)
    func showPostsFromCategoryError(error: String)
}

class FeedViewController: BaseViewController, FeedViewControllerProtocol {
    enum SectionKind: Int, CaseIterable {
        case category, products
        var columnCount: Int {
            switch self {
            case .category:
                return 1
            case .products:
                return 2
            }
        }
    }
    
    var news: [News] = []
    var categories: [Categories] = []
    var media: [Media] = []
    
    let refreshControl = UIRefreshControl()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, AnyHashable>! = nil
    
    var presenter: FeedPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCategories()
        presenter?.getPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
        
        setupCollectionView()
        setupDataSource()
        setupSubviews()
        setupConstraints()
        
        collectionView.isHidden = true
        
//        reloadData()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logoutAction))
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(CategoryFeedCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
}


extension FeedViewController: UICollectionViewDelegateFlowLayout {
    @objc func logoutAction() {
        KeychainWrapper.standard.removeObject(forKey: "token")
        KeychainWrapper.standard.removeObject(forKey: "user_email")
        KeychainWrapper.standard.removeObject(forKey: "user_nicename")
        KeychainWrapper.standard.removeObject(forKey: "user_display_name")
        
        // Переход на экран логина, если вышел
        // TODO: Под вопросом если честно.
//        let authViewController = UIStoryboard(name: "Main",
//                                              bundle: nil)
//            .instantiateViewController(withIdentifier: "SignInController") as! SignInController
//        authViewController.modalPresentationStyle = .fullScreen
//        present(authViewController, animated:true, completion:nil)
        
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable>(collectionView: collectionView, cellProvider: { [self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)
            switch section {
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryFeedCell
                cell.setupCell(categories[indexPath.item])
                return cell
                
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! FeedCell
                cell.setupCell(news[indexPath.item])
                return cell
                
            case .none:
                return nil
                
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, AnyHashable>()
        
        snapshot.appendSections([.category])
        snapshot.appendItems(categories, toSection: .category)
        
        snapshot.appendSections([.products])
        snapshot.appendItems(news, toSection: .products)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = SectionKind(rawValue: sectionIndex)
            switch section {
            case .category:
                return self.createCategorySection()
            case .products:
                return self.createProductsSection()
            case .none:
                return nil
            }
        }
        return layout
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(120))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    private func createProductsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter?.getFilterCategory(id: categories[indexPath.item].id ?? 0)
            
            // TODO: Сделать по умному
            self.news = []
            self.reloadData()
            self.collectionView.reloadData()
            self.activityIndicator.startAnimating()
            // Конец тупости
            
        } else if indexPath.section == 1 {
            presenter?.routeToDetail(idPost: news[indexPath.item].id ?? 0)
        } else {
            
        }
    }
    
}

extension FeedViewController {
    
    @objc private func refreshData(_ sender: Any) {
        presenter?.getPosts()
    }
    
    func newsDataReload(news: [News]) {
        DispatchQueue.main.async {
            self.news = news
            self.refreshControl.endRefreshing()
            self.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func setCategories(cat: [Categories]) {
        DispatchQueue.main.async {
            self.categories = cat
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setPostsFromCategory(posts: [News]) {
        DispatchQueue.main.async {
            self.news = posts
            self.reloadData()
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func showCategoriesError(error: String) {
        DispatchQueue.main.async {
            print("LOG: ОШИБКА КАТЕГОРИИ ВЬЮ: \(error)")
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            print("LOG: ОШИБКА ПОСТЫ ВЬЮ: \(error)")
        }
    }
    
    func showPostsFromCategoryError(error: String) {
        DispatchQueue.main.async {
            print("LOG: ОШИБКА ПОКАЗА ПОСТОВ ИЗ КАТЕГОРИИ ВЬЮ: \(error)")
        }
    }
    
}
