//
//  CalendarsViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/9/24.
//

import SwiftUI
import EventKit

class EventStoreManager: ObservableObject {
    private let eventStore = EKEventStore()
    @Published var events: [EKEvent] = []
    
    func requestAccess() {
        eventStore.requestFullAccessToEvents { granted, error in
            if granted {
                self.fetchEvents()
            } else {
                print("Access denied or error: \(String(describing: error))")
            }
        }
    }
    
    func fetchEvents() {
        let calendars = eventStore.calendars(for: .event)
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: calendars)
        self.events = eventStore.events(matching: predicate)
    }
}
