//
//  ViewExtension.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/12/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func navigationBarModifier( foregroundColor: UIColor = .label, tintColor: UIColor?, withSeparator: Bool) -> some View {
        self.modifier(NavigationBarModifier( foregroundColor: foregroundColor, tintColor: tintColor, withSeparator: withSeparator))
    }
}
