//
//  DateExtension.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/9/24.
//

import Foundation

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
    
    func todyaDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년-MM월-dd일"
        return dateFormatter.string(from: Date())
    }
    
    func todayDateWithTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
