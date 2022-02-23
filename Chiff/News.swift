//
//  News.swift
//  Chiff
//
//  Created by Zakirov Tahir on 11.04.2021.
//

import Foundation

struct News: Codable, Hashable {
    let id: Int?
    let date, dateGmt: String?
    let guid: GUID?
    let modified, modifiedGmt, slug, status: String?
    let type: String?
    let link: String?
    let title: GUID?
    let content, excerpt: Content?
    let author, featuredMedia: Int?
    let commentStatus, pingStatus: String?
    let sticky: Bool?
    let template, format: String?
    let categories: [Int]?
    let links: Linkes?
    let cost: String?

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
    } 
}

// MARK: - Content
struct Content: Codable, Hashable {
    let rendered: String?
    let protected: Bool?
}

// MARK: - GUID
struct GUID: Codable, Hashable {
    let rendered: String?
}


// MARK: - Links
struct Linkes: Codable, Hashable {
    let linksSelf, collection, about: [About]?
    let replies: [Reply]?
    let versionHistory: [VersionHistory]?
    let wpFeaturedmedia: [Reply]?
    let wpAttachment: [About]?
    let wpTerm: [WpTerm]?
    let curies: [Cury]?

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
    let href: String?
}

// MARK: - Cury
struct Cury: Codable, Hashable {
    let name, href: String?
    let templated: Bool?
}

// MARK: - Reply
struct Reply: Codable, Hashable {
    let embeddable: Bool?
    let href: String?
}

// MARK: - VersionHistory
struct VersionHistory: Codable, Hashable {
    let count: Int?
    let href: String?
}

// MARK: - WpTerm
struct WpTerm: Codable, Hashable {
    let taxonomy: String?
    let embeddable: Bool?
    let href: String?
}