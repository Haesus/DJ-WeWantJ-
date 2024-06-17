//
//  TodoTemplateModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import Foundation

struct TodoTemplateModel: Codable, Hashable {
    var todoList: [Todo]
}

struct Todo: Codable, Hashable {
    var isTodo: Bool
    var todoText: String
}
