//
//  MainView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var signViewModel: SignViewModel
    
    var body: some View {
        NavigationStack {
            if signViewModel.isSignedIn {
                TabBarView()
            } else {
                SignInView()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SignViewModel())
}
