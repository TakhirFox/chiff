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
    let links: Links?
    let avatarimage: Avatarimage?
    let numberphone, lastname, firstname: String?
}

// MARK: - Avatarimage
struct Avatarimage: Decodable {
    let id, postAuthor, postDate, postDateGmt: String?
    let postContent, postTitle, postExcerpt, postStatus: String?
    let commentStatus, pingStatus, postPassword, postName: String?
    let toPing, pinged, postModified, postModifiedGmt: String?
    let postContentFiltered, postParent: String?
    let guid: String?
    let menuOrder, postType, postMIMEType, commentCount: String?
    let podItemID: String?
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
