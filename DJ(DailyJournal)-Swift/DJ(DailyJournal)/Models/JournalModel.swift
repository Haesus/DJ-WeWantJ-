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
    let journalImages: [NewJournalImage]?
    let userID: Int
}

struct UpdatedJournal: Codable {
    let id: Int
    let journalTitle: String
    let journalText: String
    let imageData: [Data]?
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
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, journalTitle, journalText, createdAt, userID
        case journalImages = "JournalImages"
    }
}

struct NewJournalImage: Codable {
    let journalImageString: String
    let journalID: Int
}

struct JournalImage: Codable {
    let id: Int
    let journalImageString: String
    let journalID: Int
}
