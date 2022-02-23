//
//  TabBarInteractor.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.02.2022.
//

import Foundation

protocol TabBarInteractorProtocol {
    
}

class TabBarInteractor: BaseInteractor, TabBarInteractorProtocol {
    weak var presenter: TabBarPresenterProtocol?
}
