//
//  CalendarsTestView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/9/24.
//

import SwiftUI

struct CalendarsTestView: View {
    @StateObject private var eventStoreManager = EventStoreManager()
    
    var body: some View {
        NavigationView {
            List(eventStoreManager.events, id: \.eventIdentifier) { event in
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    Text(event.startDate, style: .date)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Calendar Events")
            .onAppear {
//                eventStoreManager.requestAccess()
            }
        }
    }
}

#Preview {
    CalendarsTestView()
}
