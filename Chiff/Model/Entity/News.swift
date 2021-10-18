//
//  News.swift
//  Chiff
//
//  Created by Zakirov Tahir on 11.04.2021.
//

import Foundation

// MARK: - News
class News: Decodable {
    let id: Int?
    let date: String?
    let dateGmt: String?
    let guid: GUID?
    let modified: String?
    let modifiedGmt: String?
    let slug: String?
    let status: String?
    let type: String?
    let link: String?
    let title: GUID?
    let content: Content?
    let excerpt: Content?
    let author: Int?
    let featuredMedia: Int?
    let commentStatus: String?
    let pingStatus: String?
    let sticky: Bool?
    let template: String?
    let format: String?
//    let meta: [Any?]?
    let categories: [Int]?
//    let tags: [Any?]?
    let links: Linkes?

    init(id: Int?, date: String?, dateGmt: String?, guid: GUID?, modified: String?, modifiedGmt: String?, slug: String?, status: String?, type: String?, link: String?, title: GUID?, content: Content?, excerpt: Content?, author: Int?, featuredMedia: Int?, commentStatus: String?, pingStatus: String?, sticky: Bool?, template: String?, format: String?, meta: [Any?]?, categories: [Int]?, tags: [Any?]?, links: Linkes?) {
        self.id = id
        self.date = date
        self.dateGmt = dateGmt
        self.guid = guid
        self.modified = modified
        self.modifiedGmt = modifiedGmt
        self.slug = slug
        self.status = status
        self.type = type
        self.link = link
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.author = author
        self.featuredMedia = featuredMedia
        self.commentStatus = commentStatus
        self.pingStatus = pingStatus
        self.sticky = sticky
        self.template = template
        self.format = format
//        self.meta = meta
        self.categories = categories
//        self.tags = tags
        self.links = links
    }
}

// MARK: - Content
class Content: Decodable {
    let rendered: String?
    let protected: Bool?

    init(rendered: String?, protected: Bool?) {
        self.rendered = rendered
        self.protected = protected
    }
}

// MARK: - GUID
class GUID: Decodable {
    let rendered: String?

    init(rendered: String?) {
        self.rendered = rendered
    }
}

// MARK: - Links
class Linkes: Decodable {
    let linksSelf: [About]?
    let collection: [About]?
    let about: [About]?
    let author: [Author]?
    let replies: [Author]?
    let versionHistory: [VersionHistory]?
    let predecessorVersion: [PredecessorVersion]?
    let wpFeaturedmedia: [Author]?
    let wpAttachment: [About]?
    let wpTerm: [WpTerm]?
    let curies: [Cury]?

    init(linksSelf: [About]?, collection: [About]?, about: [About]?, author: [Author]?, replies: [Author]?, versionHistory: [VersionHistory]?, predecessorVersion: [PredecessorVersion]?, wpFeaturedmedia: [Author]?, wpAttachment: [About]?, wpTerm: [WpTerm]?, curies: [Cury]?) {
        self.linksSelf = linksSelf
        self.collection = collection
        self.about = about
        self.author = author
        self.replies = replies
        self.versionHistory = versionHistory
        self.predecessorVersion = predecessorVersion
        self.wpFeaturedmedia = wpFeaturedmedia
        self.wpAttachment = wpAttachment
        self.wpTerm = wpTerm
        self.curies = curies
    }
}

// MARK: - About
class About: Decodable {
    let href: String?

    init(href: String?) {
        self.href = href
    }
}

// MARK: - Author
class Author: Decodable {
    let embeddable: Bool?
    let href: String?

    init(embeddable: Bool?, href: String?) {
        self.embeddable = embeddable
        self.href = href
    }
}

// MARK: - Cury
class Cury: Decodable {
    let name: String?
    let href: String?
    let templated: Bool?

    init(name: String?, href: String?, templated: Bool?) {
        self.name = name
        self.href = href
        self.templated = templated
    }
}

// MARK: - PredecessorVersion
class PredecessorVersion: Decodable {
    let id: Int?
    let href: String?

    init(id: Int?, href: String?) {
        self.id = id
        self.href = href
    }
}

// MARK: - VersionHistory
class VersionHistory: Decodable {
    let count: Int?
    let href: String?

    init(count: Int?, href: String?) {
        self.count = count
        self.href = href
    }
}

// MARK: - WpTerm
class WpTerm: Decodable {
    let taxonomy: String?
    let embeddable: Bool?
    let href: String?

    init(taxonomy: String?, embeddable: Bool?, href: String?) {
        self.taxonomy = taxonomy
        self.embeddable = embeddable
        self.href = href
    }
}

