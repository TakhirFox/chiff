//
//  Post.swift
//  Chiff
//
//  Created by Zakirov Tahir on 05.01.2022.
//

import Foundation

struct Post: Codable, Hashable {
    var id: Int?
    var title: String?
    var author: String?
    var image: String?
}
