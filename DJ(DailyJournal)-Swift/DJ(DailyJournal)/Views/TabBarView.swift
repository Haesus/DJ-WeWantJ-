//
//  TabBarView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Tab = .dailyjournal
    
    enum Tab {
        case dailyjournal
        case todolist
        case dailyLog
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                // TODO: - JournalListView로 수정
                TabBarView1()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tab.dailyjournal)
                
                TodoListView()
                    .tabItem {
                        Image(systemName: "checkmark.seal")
                        Text("Todo")
                    }
                    .tag(Tab.todolist)
              
                DailyLogView()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("DailyLog")
                    }
                    .tag(Tab.dailyLog)
            }
            .tint(Color.lightYellow)
            .onAppear() {
                UITabBar.appearance().unselectedItemTintColor = .gray
            }
            .navigationTitle(navigationTitle(for: selectedTab))
        }
    }
    
    private func navigationTitle(for tab: Tab) -> String {
        switch tab {
            case .dailyjournal:
                return "Daily Journal"
            case .todolist:
                return "Todo List"
            case .dailyLog:
                return "Daily Log"
        }
    }
}

struct TabBarView1: View {
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Text("Journal View")
            }
        }
    }
}

struct TabBarView2: View {
    var body: some View {
        NavigationView {
            Text("Profile View")
                .navigationTitle("Profile")
        }
    }
}

#Preview {
    TabBarView()
}
