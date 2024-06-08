//
//  DailyLogTemplateModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/7/24.
//

import Foundation

struct DailyTemplateModel: Codable, Hashable {
    var dailyLogList: [DailyLog]
}

struct DailyLog: Codable, Hashable {
    var isDaily: String
    var dailyText: String
}
