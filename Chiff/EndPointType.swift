//
//  EndPointType.swift
//  Chiff
//
//  Created by admin on 23.03.2022.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var header: HTTPHeaders? { get }
    
}
