//
//  DJ_DailyJournal_App.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/2/24.
//

import SwiftUI

@main
struct DJ_DailyJournal_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
