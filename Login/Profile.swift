//
//  Profile.swift
//  Login
//
//  Created by 윤여진 on 2022/11/03.
//

import Foundation

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

struct Profile: Codable {
    let user: User
}
