//
//  DJ_DailyJournal_App.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/2/24.
//

import SwiftUI

@main
struct DJ_DailyJournal_App: App {
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UNUserNotificationCenter.current().delegate = NotificationDelegate()
                }
        }
        .onChange(of: phase, { oldPhase, newPhase in
            switch newPhase {
                case .background: scheduleAppRefresh()
                default: break
            }
        })
        .backgroundTask(.appRefresh("myapprefresh")) {
            print("test")
//            let request = URLRequest(url: URL(string: "your_backend")!)
//            guard let data = try? await URLSession.shared.data(for: request).0 else {
//                return
//            }
//            
//            let decoder = JSONDecoder()
//            guard let products = try? decoder.decode([Product].self, from: data) else {
//                return
//            }
//            
//            if !products.isEmpty && !Task.isCancelled {
//                await notifyUser(for: products)
//            }
        }
    }
}
