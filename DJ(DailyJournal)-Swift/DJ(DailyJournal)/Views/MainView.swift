//
//  MainView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var signViewModel = SignViewModel()
    @State private var showLaunchScreen = true
        
        var body: some View {
            ZStack {
                NavigationStack {
                    if signViewModel.isSignedIn {
                        TabBarView()
                            .environmentObject(signViewModel)
                    } else {
                        SignInView()
                            .environmentObject(signViewModel)
                    }
                }
                .opacity(showLaunchScreen ? 0 : 1)

                if showLaunchScreen {
                    LaunchScreenView()
                        .transition(.opacity)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    withAnimation {
                        self.showLaunchScreen = false
                    }
                }
            }
        }
    }

#Preview {
    MainView()
}
