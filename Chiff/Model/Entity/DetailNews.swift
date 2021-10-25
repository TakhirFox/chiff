//
//  DetailNews.swift
//  Chiff
//
//  Created by Zakirov Tahir on 25.10.2021.
//

import Foundation

// MARK: - DetailNews
struct DetailNews: Codable {
    let id: Int?
    let date: String?
    let dateGmt: String?
    let guid: StatusGUID?
    let modified: String?
    let modifiedGmt: String?
    let slug: String?
    let status: String?
    let type: String?
    let link: String?
    let title: StatusGUID?
    let content: StatusContent?
    let excerpt: StatusContent?
    let author: Int?
    let featuredMedia: Int?
    let commentStatus: String?
    let pingStatus: String?
    let sticky: Bool?
    let template: String?
    let format: String?
    let categories: [Int]?
    let images: [StatusImage]?
    let cost: String?
    let links: StatusLinks?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case dateGmt = "date_gmt"
        case guid = "guid"
        case modified = "modified"
        case modifiedGmt = "modified_gmt"
        case slug = "slug"
        case status = "status"
        case type = "type"
        case link = "link"
        case title = "title"
        case content = "content"
        case excerpt = "excerpt"
        case author = "author"
        case featuredMedia = "featured_media"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case sticky = "sticky"
        case template = "template"
        case format = "format"
        case categories = "categories"
        case images = "images"
        case cost = "cost"
        case links = "_links"
    }
}


// MARK: - StatusContent
struct StatusContent: Codable {
    let rendered: String?
    let protected: Bool?

    enum CodingKeys: String, CodingKey {
        case rendered = "rendered"
        case protected = "protected"
    }
}


// MARK: - StatusGUID
struct StatusGUID: Codable {
    let rendered: String?

    enum CodingKeys: String, CodingKey {
        case rendered = "rendered"
    }
}


// MARK: - StatusImage
struct StatusImage: Codable {
    let id: String?
    let postAuthor: String?
    let postDate: String?
    let postDateGmt: String?
    let postContent: String?
    let postTitle: String?
    let postExcerpt: String?
    let postStatus: String?
    let commentStatus: String?
    let pingStatus: String?
    let postPassword: String?
    let postName: String?
    let toPing: String?
    let pinged: String?
    let postModified: String?
    let postModifiedGmt: String?
    let postContentFiltered: String?
    let postParent: String?
    let guid: String?
    let menuOrder: String?
    let postType: String?
    let postMIMEType: String?
    let commentCount: String?
    let podItemID: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case postAuthor = "post_author"
        case postDate = "post_date"
        case postDateGmt = "post_date_gmt"
        case postContent = "post_content"
        case postTitle = "post_title"
        case postExcerpt = "post_excerpt"
        case postStatus = "post_status"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case postPassword = "post_password"
        case postName = "post_name"
        case toPing = "to_ping"
        case pinged = "pinged"
        case postModified = "post_modified"
        case postModifiedGmt = "post_modified_gmt"
        case postContentFiltered = "post_content_filtered"
        case postParent = "post_parent"
        case guid = "guid"
        case menuOrder = "menu_order"
        case postType = "post_type"
        case postMIMEType = "post_mime_type"
        case commentCount = "comment_count"
        case podItemID = "pod_item_id"
    }
}


// MARK: - StatusLinks
struct StatusLinks: Codable {
    let linksSelf: [StatusAbout]?
    let collection: [StatusAbout]?
    let about: [StatusAbout]?
    let author: [StatusAuthor]?
    let replies: [StatusAuthor]?
    let versionHistory: [StatusVersionHistory]?
    let predecessorVersion: [StatusPredecessorVersion]?
    let wpAttachment: [StatusAbout]?
    let wpTerm: [StatusWpTerm]?
    let curies: [StatusCury]?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection = "collection"
        case about = "about"
        case author = "author"
        case replies = "replies"
        case versionHistory = "version-history"
        case predecessorVersion = "predecessor-version"
        case wpAttachment = "wp:attachment"
        case wpTerm = "wp:term"
        case curies = "curies"
    }
}


// MARK: - StatusAbout
struct StatusAbout: Codable {
    let href: String?

    enum CodingKeys: String, CodingKey {
        case href = "href"
    }
}


// MARK: - StatusAuthor
struct StatusAuthor: Codable {
    let embeddable: Bool?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case embeddable = "embeddable"
        case href = "href"
    }
}

// MARK: - StatusCury
struct StatusCury: Codable {
    let name: String?
    let href: String?
    let templated: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case href = "href"
        case templated = "templated"
    }
}


// MARK: - StatusPredecessorVersion
struct StatusPredecessorVersion: Codable {
    let id: Int?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case href = "href"
    }
}


// MARK: - StatusVersionHistory
struct StatusVersionHistory: Codable {
    let count: Int?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case href = "href"
    }
}


// MARK: - StatusWpTerm
struct StatusWpTerm: Codable {
    let taxonomy: String?
    let embeddable: Bool?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case taxonomy = "taxonomy"
        case embeddable = "embeddable"
        case href = "href"
    }
}
