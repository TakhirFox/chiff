//
//  News.swift
//  Chiff
//
//  Created by Zakirov Tahir on 11.04.2021.
//

import Foundation

struct News: Codable, Hashable {
    var id: Int?
    var date, dateGmt: String?
    var guid: GUID?
    var modified, modifiedGmt, slug, status: String?
    var type: String?
    var link: String?
    var title: GUID?
    var content, excerpt: Content?
    var author, featuredMedia: Int?
    var commentStatus, pingStatus: String?
    var sticky: Bool?
    var template, format: String?
    var categories: [Int]?
    var links: Linkes?
    var cost: String?
    var authorName: String?
    var imagesPost: [String]?

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case guid, modified
        case modifiedGmt = "modified_gmt"
        case slug, status, type, link, title, content, excerpt, author
        case featuredMedia = "featured_media"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case cost = "cost"
        case sticky, template, format, categories
        case links = "_links"
        case authorName
        case imagesPost
    } 
}

// MARK: - Content
struct Content: Codable, Hashable {
    var rendered: String?
    var protected: Bool?
}

// MARK: - GUID
struct GUID: Codable, Hashable {
    var rendered: String?
}


// MARK: - Links
struct Linkes: Codable, Hashable {
    var linksSelf, collection, about: [About]?
    var replies: [Reply]?
    var versionHistory: [VersionHistory]?
    var wpFeaturedmedia: [Reply]?
    var wpAttachment: [About]?
    var wpTerm: [WpTerm]?
    var curies: [Cury]?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection, about, replies
        case versionHistory = "version-history"
        case wpFeaturedmedia = "wp:featuredmedia"
        case wpAttachment = "wp:attachment"
        case wpTerm = "wp:term"
        case curies
    }
}

// MARK: - About
struct About: Codable, Hashable {
    var href: String?
}

// MARK: - Cury
struct Cury: Codable, Hashable {
    var name, href: String?
    var templated: Bool?
}

// MARK: - Reply
struct Reply: Codable, Hashable {
    var embeddable: Bool?
    var href: String?
}

// MARK: - VersionHistory
struct VersionHistory: Codable, Hashable {
    var count: Int?
    var href: String?
}

// MARK: - WpTerm
struct WpTerm: Codable, Hashable {
    var taxonomy: String?
    var embeddable: Bool?
    var href: String?
}
