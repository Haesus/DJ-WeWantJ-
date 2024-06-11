//
//  ContentView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var notificationGranted = false

    var signViewModel = SignViewModel()
    @StateObject var journalListViewModel = JournalListViewModel()
    
    var body: some View {
        MainView()
            .environmentObject(SignViewModel())
            .environmentObject(journalListViewModel)
            .onAppear {
                requestNotificationPermission()
            }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.notificationGranted = granted
                    if granted {
                        self.scheduleDailyNotification(at: 15)
                    }
                }
            }
        }
    }
    
    private func scheduleDailyNotification(at hour: Int) {
        let content = UNMutableNotificationContent()
        content.title = "일기 작성"
        content.body = "일기를 저장할 시간입니다.."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = 03
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                // 여기서 일기 저장 로직 실행
                print("Notification scheduled successfully.")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SignViewModel())
}
