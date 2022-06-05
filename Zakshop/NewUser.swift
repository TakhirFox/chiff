//
//  NewUser.swift
//  Chiff
//
//  Created by Zakirov Tahir on 18.03.2022.
//

import Foundation

struct NewUser: Decodable {
//    var id: Int?
    var username: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    var firstname: String?
    var lastname: String?
    var numberphone: String?
    var userBio: String?
    var avatarImage: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case password
        case confirmPassword
        case firstname
        case lastname
        case numberphone
        case userBio
        case avatarImage
    }
    
}
