//
//  JournalModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/5/24.
//

import Foundation

// 보내는 용도
struct CreatedJournal: Codable {
    let journalTitle: String
    let journalText: String
    let createdAt: String
    let journalImages: [JournalImage]?
    let userID: String
}

struct JournalResponse: Codable {
    let success: Bool
    let documents: [Journal]
    let message: String
}

// 받은 용도
struct Journal: Codable {
    let id: Int
    let journalTitle: String
    let journalText: String
    let createdAt: String
    let journalImages: [JournalImage]?
    let userID: String
}

struct JournalImage: Codable {
    let id: String
    let journalImageString: String
    let journalID: String
}
