//
//  ContentView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    var signViewModel = SignViewModel()
    
    var body: some View {
        ImageTestView()
//        MainView()
//            .environmentObject(SignViewModel())
    }
}

#Preview {
    ContentView()
        .environmentObject(SignViewModel())
}
