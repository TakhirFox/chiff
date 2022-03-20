//
//  ChatList.swift
//  Chiff
//
//  Created by Zakirov Tahir on 19.03.2022.
//

import Foundation

// MARK: - ChatList
struct ChatList: Codable {
    let id, messageID, lastSenderID: Int?
    let subject, excerpt, message: Excerpt?
    let date, dateGmt: String?
    let unreadCount: Int?
    let senderIDS: [String: Int]?
    let recipients: [String: Recipient]?
    let messages: [MessageElement]?
//    let starredMessageIDS: [JSONAny]?
//    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case messageID = "message_id"
        case lastSenderID = "last_sender_id"
        case subject, excerpt, message, date
        case dateGmt = "date_gmt"
        case unreadCount = "unread_count"
        case senderIDS = "sender_ids"
        case recipients, messages
//        case starredMessageIDS = "starred_message_ids"
//        case links = "_links"
    }
}

// MARK: - Excerpt
struct Excerpt: Codable {
    let rendered: String?
}

// MARK: - Links
//struct Links: Codable {
//    let the3, the4, the5, the6: [The3]?
//    let linksSelf, collection: [The3]?
//
//    enum CodingKeys: String, CodingKey {
//        case the3 = "3"
//        case the4 = "4"
//        case the5 = "5"
//        case the6 = "6"
//        case linksSelf = "self"
//        case collection
//    }
//}
//
//// MARK: - The3
//struct The3: Codable {
//    let href: String?
//}

// MARK: - MessageElement
struct MessageElement: Codable {
    let id, threadID, senderID: Int?
    let subject, message: SubjectClass?
    let dateSent: String?
    let isStarred: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case threadID = "thread_id"
        case senderID = "sender_id"
        case subject, message
        case dateSent = "date_sent"
        case isStarred = "is_starred"
    }
}

// MARK: - SubjectClass
struct SubjectClass: Codable {
    let raw, rendered: String?
}

// MARK: - Recipient
struct Recipient: Codable {
    let id, userID: Int?
    let userLink: String?
    let userAvatars: UserAvatars?
    let threadID, unreadCount, senderOnly, isDeleted: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userLink = "user_link"
        case userAvatars = "user_avatars"
        case threadID = "thread_id"
        case unreadCount = "unread_count"
        case senderOnly = "sender_only"
        case isDeleted = "is_deleted"
    }
}

// MARK: - UserAvatars
struct UserAvatars: Codable {
    let full, thumb: String?
}
