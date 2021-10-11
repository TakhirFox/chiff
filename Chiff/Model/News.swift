//
//  News.swift
//  Chiff
//
//  Created by Zakirov Tahir on 11.04.2021.
//

import Foundation

struct News: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
