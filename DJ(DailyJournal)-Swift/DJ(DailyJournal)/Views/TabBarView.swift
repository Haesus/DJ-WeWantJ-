//
//  TabBarView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var signViewModel: SignViewModel

    var body: some View {
        TabView() {
            JournalListView()
                .environmentObject(journalListViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            TodoListView()
                .tabItem {
                    Image(systemName: "checkmark.seal")
                    Text("Todo")
                }
            
            DailyLogView()
                .tabItem {
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("DailyLog")
                }
        }
        .tint(Color.lightYellow)
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = .gray
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(SignViewModel())
}
