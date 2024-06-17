//
//  CalendarsViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/9/24.
//

import SwiftUI
import EventKit

class EventStoreManager: ObservableObject {
    @Published var events: [EKEvent] = []
    
    private let eventStore = EKEventStore()
    
    func requestAccess() async {
        let granted = await withCheckedContinuation { continuation in
            eventStore.requestFullAccessToEvents { granted, error in
                if let error = error {
                    print("Access denied or error: \(String(describing: error))")
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: granted)
                }
            }
        }
        
        if granted {
            await fetchEvents()
        }
    }
    
    private func fetchEvents() async {
        let calendars = eventStore.calendars(for: .event)
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: calendars)
        
        await withCheckedContinuation { continuation in
            let events = self.eventStore.events(matching: predicate)
            DispatchQueue.main.async {
                self.events = events
                continuation.resume(returning: ())
            }
        }
    }
}
