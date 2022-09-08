//
//  NetworkError.swift
//  Chiff
//
//  Created by admin on 23.03.2022.
//

import Foundation

public enum NetworkErrors: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingUrl = "URL is nil."
}
