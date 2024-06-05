//
//  UserModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import Foundation

struct SignUpResponse:Codable {
    let success: Bool
    let document: [User]
    let message: String
}

struct User: Codable {
    let userID: String
    let userNickName: String?
}

struct SignInResponse: Codable {
    let success: Bool
    let token: String
    let document: [User]
    let message: String
}
