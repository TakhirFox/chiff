//
//  HTTPTask.swift
//  
//
//  Created by admin on 23.03.2022.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
}
