//
//  Categories.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import Foundation

// MARK: - Categories
struct Categories: Codable, Hashable {
    let id, count: Int?
    let welcomeDescription: String?
    let link: String?
    let name, slug: String?
//    let taxonomy: Taxonomy?
    let parent: Int?
//    let meta, acf: [Any?]?
    let iconcats: Iconcats?
//    let links: Links?
}

// MARK: - Iconcats
struct Iconcats: Codable, Hashable {
    let id, postAuthor, postDate, postDateGmt: String?
    let postContent, postTitle, postExcerpt: String?
//    let postStatus: PostStatus?
//    let commentStatus: CommentStatus?
//    let pingStatus: PingStatus?
    let postPassword, postName, toPing, pinged: String?
    let postModified, postModifiedGmt, postContentFiltered, postParent: String?
    let guid: String?
    let menuOrder: String?
//    let postType: PostType?
//    let postMIMEType: PostMIMEType?
    let commentCount, podItemID: String?
}

//enum CommentStatus: Decodable {
//    case commentStatusOpen
//}
//
//enum PingStatus: Decodable {
//    case closed
//}
//
//enum PostMIMEType: Decodable {
//    case imageJPEG
//    case imagePNG
//}
//
//enum PostStatus: Decodable {
//    case inherit
//}
//
//enum PostType: Decodable {
//    case attachment
//}

//// MARK: - Links
//struct Links {
//    let linksSelf, collection, about, wpPostType: [About]?
//    let curies: [Cury]?
//}
//
//// MARK: - About
//struct About {
//    let href: String?
//}
//
//// MARK: - Cury
//struct Cury {
//    let name: Name?
//    let href: Href?
//    let templated: Bool?
//}

//enum Href: Decodable {
//    case httpsAPIWOrgRel
//}
//
//enum Name: Decodable {
//    case wp
//}
