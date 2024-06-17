//
//  DailyJournal.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import Foundation

struct DailyJournal: Identifiable {
    let id: UUID
    var title: String
    var content: String
    let createdAt: Date
    
    init(id: UUID = UUID(), content: String, date: Date) {
        self.id = id
        self.title = DailyJournal.date(date)
        self.content = content
        self.createdAt = date
    }
    
    static func date(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

extension DailyJournal {
    static let sampleData: [DailyJournal] =
    [
        DailyJournal(
            content: "Schedule\n* 20:00-21:00 |\n\nTo-do\n\nDaily log\n수면 |\n아침 |\n점심 |\n저녁 |\n간식 | \n운동 |\n공부 |\n* 20:00-21:00 |\n\nTo-do\n\nDaily log\n수면 |\n아침 |\n점심 |\n저녁 |\n간식 | \n운동 |\n공부 |\n* 20:00-21:00 |\n\nTo-do\n\nDaily log\n수면 |\n아침 |\n점심 |\n저녁 |\n간식 | \n운동 |\n공부 |",
            date: Date()
        ),
        DailyJournal(
            content: "Schedule\n* 20:00-21:00 |\nTo-do\nDaily log\n수면 |\n아침 |\n점심 |\n저녁 |\n간식 | \n운동 |\n공부 |",
            date: Date().addingTimeInterval(-86400)
        ),
        DailyJournal(
            content: "Schedule\n* 20:00-21:00 |\nTo-do\nDaily log\n수면 |\n아침 |\n점심 |\n저녁 |\n간식 | \n운동 |\n공부 |",
            date: Date().addingTimeInterval(-7 * 86400)
        )
    ]
}
