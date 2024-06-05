//
//  TodoListView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        Group {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .navigationTitle("TodoList")
    }
}

#Preview {
    TodoListView()
}
