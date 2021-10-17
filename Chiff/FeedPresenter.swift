//
//  FeedPresenter.swift
//  Chiff
//
//  Created by admin on 13.10.2021.
//

import Foundation

protocol FeedView: AnyObject {
    func someFuncForNetworking()
}

class FeedPresenter {
    
    weak var view: FeedView?
    
    var networkService = NetworkService()
    
    public func setViewDelegate(view: FeedView) {
        self.view = view
    }
    
    public func someFunc() {
        
    }
    
    
}

