//
//  Auth.swift
//  Chiff
//
//  Created by Zakirov Tahir on 20.04.2021.
//

import Foundation

struct Auth: Decodable {
    let token: String?
    let user_email: String?
    let user_nicename: String?
    let user_display_name: String?
    let user_id: String?
}
