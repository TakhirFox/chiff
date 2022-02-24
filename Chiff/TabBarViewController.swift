//
//  TabBarViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import UIKit

protocol TabBarViewControllerProtocol: AnyObject {
    var presenter: TabBarPresenterProtocol? { get set }
}

class TabBarViewController: UITabBarController, TabBarViewControllerProtocol {
    
    var presenter: TabBarPresenterProtocol?
    var index: Int?
    
    override func viewDidLoad() {
        setupTabItems()
    }
    
    init(presenter: TabBarPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabItems() {
        viewControllers = [
            createNavController(viewController: FeedAssembly.create(), title: "Feed", image: UIImage(systemName: "rectangle.on.rectangle")!),
            createNavController(viewController: CreatePostController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Добавить", image: UIImage(systemName: "plus.square")!),
            createNavController(viewController: ProfileController(), title: "Профиль", image: UIImage(systemName: "person.crop.circle")!)
        ]
    }

}

extension TabBarViewController {
    func createNavController(viewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navConroller = UINavigationController(rootViewController: viewController)
        navConroller.tabBarController?.title = title
        navConroller.tabBarItem.image = image
        viewController.navigationItem.title = title
        navConroller.tabBarItem.title = title
        return navConroller
    }
}
