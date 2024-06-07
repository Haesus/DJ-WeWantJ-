//
//  TabBarView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        NavigationStack {
            TabView() {
                // TODO: - JournalListView로 수정
                TabBarView1()
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


#Preview {
    TabBarView()
}
