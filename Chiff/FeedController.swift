//
//  FeedController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit
import SwiftUI
import SwiftKeychainWrapper
import Kingfisher

class FeedController: UIViewController {
    
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

    let cellId = "cellId"
    let categoryCell = "categoryCell"
    var currentPage = 1
    var isLoadedPage: Bool = false

    var news = [News]()
    var categories = [Categoryes]()
    var user: User?
    var auth: Auth?
    var media: [Media]?
    let networkService = NetworkService()
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, AnyHashable>! = nil
    var collectionView: UICollectionView!

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

        fakeData()
        
    }
    
    private func fakeData() {
        categories = [Categoryes(id: 1, title: "Личные вещи", image: "One"),
                      Categoryes(id: 2, title: "Транспорт", image: "Two"),
                      Categoryes(id: 3, title: "Работа", image: "Three"),
                      Categoryes(id: 4, title: "Запчасти и аксессуары", image: "One"),
                      Categoryes(id: 5, title: "Для дома и дачи", image: "Two"),
                      Categoryes(id: 6, title: "Недвижимость", image: "Three"),
                      Categoryes(id: 7, title: "Предложение услуг", image: "One"),
                      Categoryes(id: 8, title: "Хобби и отдых", image: "Two"),
                      Categoryes(id: 9, title: "Электроника", image: "Three"),
                      Categoryes(id: 8, title: "Животные", image: "Two"),
                      Categoryes(id: 9, title: "Готовый бизнес и оборудование", image: "Three"),]
    }

    fileprivate func configureUI() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CategoryFeedCell.self, forCellWithReuseIdentifier: categoryCell)
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        collectionView.layer.cornerRadius = 20
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderColor = UIColor.black.cgColor

        setupDataSource()
//        reloadData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logoutAction))

        view.addSubview(collectionView)

        collectionView.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, AnyHashable>(collectionView: collectionView, cellProvider: { [self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)
            switch section {
            case .category:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.categoryCell, for: indexPath) as! CategoryFeedCell
                
                let categories = self.categories[indexPath.item]

                cell.titleLabel.text = categories.title
                return cell
                
            case .products:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! FeedCell

                let news = self.news[indexPath.item]
                
                cell.titleLabel.text = news.title?.rendered
                cell.authorLabel.text = nil
                cell.imageView.image = UIImage(named: "no_image")
                cell.authorLabel.text = user?.name
                
                self.presenter.loadImageForCell(idPost: news.id ?? 0)
                self.presenter.loadUsernameForCells(author: news.author ?? 0)
                
//                DispatchQueue.global().async {
                    let imageUrl = URL(string: media?[0].guid?.rendered ?? "")
//                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//                    DispatchQueue.main.async {
//                        cell.imageView.image = UIImage(data: imageData)
                        cell.imageView.kf.setImage(with: imageUrl)
//                    }
//                }
                
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


}



// MARK: - collectionView dataSource & delegate & UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {

//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return news.count
//        } else {
//            return news.count
//        }
//    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        if indexPath.section == 0 {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath)
////            cell.backgroundColor = .red
////            return cell
////        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
//
//            let news = news[indexPath.row]
//
//            cell.titleLabel.text = news.title?.rendered
//            cell.authorLabel.text = nil
//            cell.imageView.image = UIImage(named: "no_image")
//
//            presenter.loadImageForCell(idPost: news.id ?? 0)
//            presenter.loadUsernameForCells(author: news.author ?? 0)
//
//
//
//    //        DispatchQueue.global().async {
//    //            guard let imageUrl = URL(string: media[0].guid?.rendered ?? "") else { return }
//    //            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//    //            DispatchQueue.main.async {
//    //                cell.imageView.image = UIImage(data: imageData)
//    //            }
//    //        }
//
//            // TODO: Подумать, что тут можно придумать
//    //        cell.authorLabel.text = user?.name
//
//            return cell
////        }
//
//
//
//    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.idPost = news[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
        //        present(controller, animated: true, completion: nil)

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

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
        reloadData()
    }

    func presenterUsername(username: User) {
        DispatchQueue.main.async {
            self.user = username
        }
    }

    func presentImage(image: [Media]) {
        DispatchQueue.main.async {
            self.media = image
        }
    }

}

//struct FlowProvider: PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainterView: UIViewControllerRepresentable {
//        let tabBar = TabBarAssembly()
//
//        
//        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> TabBarAssembly {
//            return tabBar.create
//        }
//        
//        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
//            
//        }
//    }
//}
