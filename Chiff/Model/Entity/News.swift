//
//  News.swift
//  Chiff
//
//  Created by Zakirov Tahir on 11.04.2021.
//

import Foundation

// MARK: - News
struct News: Decodable {
    let id: Int?
    let date, dateGmt: String?
    let guid: GUID
    let modified, modifiedGmt, slug, status: String?
    let type: String?
    let link: String?
    let title: GUID?
    let content, excerpt: Content?
    let author, featuredMedia: Int?
    let commentStatus, pingStatus: String?
    let sticky: Bool?
    let template, format: String?
    let categories, tags: [Int]?
    let links: Linkes?
}

// MARK: - Content
struct Content: Decodable {
    let rendered: String?
    let protected: Bool?
}

// MARK: - GUID
struct GUID: Decodable {
    let rendered: String?
}

// MARK: - Links
struct Linkes: Decodable {
    let linksSelf, collection, about: [About]?
    let author, replies: [Author]?
    let versionHistory: [VersionHistory]?
    let predecessorVersion: [PredecessorVersion]?
    let wpFeaturedmedia: [Author]?
    let wpAttachment: [About]?
    let wpTerm: [WpTerm]?
    let curies: [Cury]?
}

// MARK: - About
struct About: Decodable {
    let href: String?
}

// MARK: - Author
struct Author: Decodable {
    let embeddable: Bool?
    let href: String?
}

// MARK: - Cury
struct Cury: Decodable {
    let name, href: String?
    let templated: Bool?
}

// MARK: - PredecessorVersion
struct PredecessorVersion: Decodable {
    let id: Int?
    let href: String?
}

// MARK: - VersionHistory
struct VersionHistory: Decodable {
    let count: Int?
    let href: String?
}

// MARK: - WpTerm
struct WpTerm: Decodable {
    let taxonomy: String?
    let embeddable: Bool?
    let href: String?
}
