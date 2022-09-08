//
//  Router.swift
//  Chiff
//
//  Created by admin on 23.03.2022.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.data
        }
    }
    
    func cancel() {
        
    }
    
}
