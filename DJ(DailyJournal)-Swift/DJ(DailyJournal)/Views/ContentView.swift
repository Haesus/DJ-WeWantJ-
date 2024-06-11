//
//  ContentView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var journalViewModel = JournalViewModel()

    var signViewModel = SignViewModel()
    
    var body: some View {
        MainView()
            .environmentObject(SignViewModel())
            .environmentObject(journalListViewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(SignViewModel())
}
