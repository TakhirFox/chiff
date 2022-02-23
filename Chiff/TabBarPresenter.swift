//
//  TabBarPresenter.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject {

}

class TabBarPresenter: BasePresenter {
    weak var view: TabBarViewControllerProtocol?
    var interactor: TabBarInteractorProtocol?
    var router: TabBarRouterProtocol?
}

extension TabBarPresenter: TabBarPresenterProtocol {
    
}
