//
//  SceneDelegate.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit
import SwiftKeychainWrapper


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let accessToken: String? = KeychainWrapper.standard.string(forKey: "token")
        
        // Чекаем, если токен сохранен, при входе запускаем майнтаббар, иначе на экран авторизации.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        if accessToken != nil {
            window?.rootViewController = MainTabBar()
            window?.makeKeyAndVisible()
        } else {
            let authViewController = SignInController() // TODO: 
//            let authViewController = AuthAssembly.create()
            window?.rootViewController = authViewController
            window?.makeKeyAndVisible()
        }
        
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

