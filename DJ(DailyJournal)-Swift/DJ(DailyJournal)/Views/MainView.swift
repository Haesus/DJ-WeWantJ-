//
//  MainView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var signViewModel = SignViewModel()
    
    var body: some View {
        NavigationStack {
            if signViewModel.isSignedIn {
                TabBarView()
                    .environmentObject(signViewModel)
            } else {
                SignInView()
                    .environmentObject(signViewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
