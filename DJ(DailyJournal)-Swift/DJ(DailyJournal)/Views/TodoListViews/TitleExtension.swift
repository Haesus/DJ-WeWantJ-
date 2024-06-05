//
//  TitleExtension.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/5/24.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    init( foregroundColor: UIColor = .blue, tintColor: UIColor?, withSeparator: Bool = true){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        if withSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationBarModifier( foregroundColor: UIColor = .label, tintColor: UIColor?, withSeparator: Bool) -> some View {
        self.modifier(NavigationBarModifier( foregroundColor: foregroundColor, tintColor: tintColor, withSeparator: withSeparator))
    }
}
