//
//  ViewExtension.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/12/24.
//

import SwiftUI

extension View {
    // 어이가 없네
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
