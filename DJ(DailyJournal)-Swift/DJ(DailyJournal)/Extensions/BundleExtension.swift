//
//  Bundle.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import Foundation

extension Bundle {
    var hostKey: String? {
        return infoDictionary?["HOST_KEY"] as? String
    }
}
