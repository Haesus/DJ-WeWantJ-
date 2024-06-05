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
            TabView {
                // TODO: - JournalView로 수정
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
            .background(Color.backgroundColor)
        }
    }
}

struct TabBarView1: View {
    var body: some View {
        NavigationView {
            EmptyView()
                .background(Color.backgroundColor)
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
