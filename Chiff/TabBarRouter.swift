//
//  TabBarRouter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import UIKit

protocol TabBarRouterProtocol: AnyObject {
    
}

class TabBarRouter: BaseRouter {
    weak var viewController: TabBarViewController!
}

extension TabBarRouter: TabBarRouterProtocol {
    
}
