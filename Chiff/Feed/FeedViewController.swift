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
    func showError(error: String)
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
    var categories: [Categoryes] = []
    var media: [Media] = []
    var user: User?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, AnyHashable>! = nil
    
    var presenter: FeedPresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        presenter?.getPosts()
        
        setupCollectionView()
        setupDataSource()
        setupSubviews()
        setupConstraints()
        
        reloadData()
        fakeData()
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logoutAction))

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(CategoryFeedCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.delegate = self
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
        let authViewController = UIStoryboard(name: "Main",
                                              bundle: nil)
            .instantiateViewController(withIdentifier: "SignInController") as! SignInController
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated:true, completion:nil)

    }
    
    private func fakeData() {
        categories = [Categoryes(id: 1, title: "Личные вещи", image: "1"),
                      Categoryes(id: 2, title: "Транспорт", image: "2"),
                      Categoryes(id: 3, title: "Работа", image: "3"),
                      Categoryes(id: 4, title: "Запчасти и аксессуары", image: "4"),
                      Categoryes(id: 5, title: "Для дома и дачи", image: "5"),
                      Categoryes(id: 6, title: "Недвижимость", image: "6"),
                      Categoryes(id: 7, title: "Предложение услуг", image: "7"),
                      Categoryes(id: 8, title: "Хобби и отдых", image: "8"),
                      Categoryes(id: 9, title: "Электроника", image: "9"),
                      Categoryes(id: 8, title: "Животные", image: "10"),
                      Categoryes(id: 9, title: "Готовый бизнес и оборудование", image: "1"),]
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(130))
        
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
        presenter?.routeToDetail(idPost: news[indexPath.item].id ?? 0)
    }
    
}

extension FeedViewController {
    func newsDataReload(news: [News]) {
        DispatchQueue.main.async {
            self.news = news
            self.collectionView.reloadData()
        }
        
        reloadData()
    }
    
    func showError(error: String) {
        print("LOG: \(error)")
    }
}
