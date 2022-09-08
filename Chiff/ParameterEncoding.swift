//
//  ParameterEncoding.swift
//  Chiff
//
//  Created by admin on 23.03.2022.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
