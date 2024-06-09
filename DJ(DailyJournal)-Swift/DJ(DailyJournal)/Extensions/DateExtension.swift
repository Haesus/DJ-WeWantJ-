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
}
