//
//  MainTabBar.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
//        self.delegate = self
        self.tabBar.backgroundColor = .black
    
        
        
        
        viewControllers = [
            createNavController(viewController: FeedController(), title: "Feed"),
            createNavController(viewController: CreatePostController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Добавить"),
            createNavController(viewController: ProfileController(), title: "Профиль")
        ]
        
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String) -> UIViewController {
        let navConroller = UINavigationController(rootViewController: viewController)
        navConroller.tabBarController?.title = title
        navConroller.tabBarItem.image = UIImage(systemName: "circlebadge.fill")
        viewController.navigationItem.title = title
        navConroller.tabBarItem.title = title
        return navConroller
    }
    
}
