//
//  User.swift
//  Chiff
//
//  Created by admin on 12.10.2021.
//

import Foundation

struct User: Decodable {
    var id: Int?
    var name: String?
    var url: String?
    var welcomeDescription: String?
    var link: String?
    var slug: String?
    var links: Links?
    var userEmail: String?
    var avatarimage: Avatarimage?
    var numberphone, lastname, firstname: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, url
        case welcomeDescription = "description"
        case link, slug
        case userEmail = "user_email"
        case avatarimage, numberphone, lastname, firstname
        case links = "_links"
    }
    
}

// MARK: - Avatarimage
struct Avatarimage: Decodable {
    var id, postAuthor, postDate, postDateGmt: String?
    var postContent, postTitle, postExcerpt, postStatus: String?
    var commentStatus, pingStatus, postPassword, postName: String?
    var toPing, pinged, postModified, postModifiedGmt: String?
    var postContentFiltered, postParent: String?
    var guid: String?
    var menuOrder, postType, postMIMEType, commentCount: String?
    var podItemID: String?
}

// MARK: - Links
struct Links: Decodable {
    var linksSelf: [Collection]?
    var collection: [Collection]?
}

// MARK: - Collection
struct Collection: Decodable {
    var href: String?
}
