//
//  SummaryModel.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/12/24.
//

import Foundation

struct SummaryResponse: Codable {
    let success: Bool
    let summaries: [Summary]
}

/**
 {
 "id": 17,
 "summary": "오늘은 병원 검진을 받고, 오류를 수정하며 책을 샀어요. 아침은 따로 없고, 점심으로는 칼국수, 저녁으로는 볶음밥을 먹었어요. 간식으로는 레몬밤차를 마셨습니다.",
 "createdAt": "2024-06-11T09:02:06.000Z",
 "updatedAt": "2024-06-11T09:02:06.000Z",
 "deletedAt": null,
 "journalID": 5
 }
 */
struct Summary: Codable {
    let summary: String
}
