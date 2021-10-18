//
//  Media.swift
//  Chiff
//
//  Created by admin on 18.10.2021.
//

import Foundation

// MARK: - Media
struct Media: Decodable {
    let id: Int?
    let date, dateGmt: String?
    let guid: Caption?
    let modified, modifiedGmt, slug, status: String?
    let type: String?
    let link: String?
    let title: Caption?
    let author: Int?
    let commentStatus, pingStatus, template: String?
    let welcomeDescription, caption: Caption?
    let altText, mediaType, mimeType: String?
    let post: Int?
    let sourceURL: String?

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case guid, modified
        case modifiedGmt = "modified_gmt"
        case slug, status, type, link, title, author
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case template
        case welcomeDescription = "description"
        case caption
        case altText = "alt_text"
        case mediaType = "media_type"
        case mimeType = "mime_type"
        case post
        case sourceURL = "source_url"
    }
}

// MARK: - Caption
struct Caption: Decodable {
    let rendered: String?
}
