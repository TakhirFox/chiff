//
//  User.swift
//  Chiff
//
//  Created by admin on 12.10.2021.
//

import Foundation

struct User: Decodable {
    let id: Int?
    let name: String?
    let url: String?
    let welcomeDescription: String?
    let link: String?
    let slug: String?
    let avatarUrls: [Avatars: String]?
    let links: Links?
}

struct Avatars: Decodable, Hashable {
    let littleImage: String?
    let middleImage: String?
    let bigImage: String?
    
    enum CodingKeys: Int, CodingKey {
        case littleImage = 24
        case middleImage = 48
        case bigImage = 64
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        littleImage = try values.decodeIfPresent(String.self, forKey: .littleImage)
        middleImage = try values.decodeIfPresent(String.self, forKey: .middleImage)
        bigImage = try values.decodeIfPresent(String.self, forKey: .bigImage)
    }
}

// MARK: - Links
struct Links: Decodable {
    let linksSelf: [Collection]?
    let collection: [Collection]?
}

// MARK: - Collection
struct Collection: Decodable {
    let href: String?
}
