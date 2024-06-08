//
//  ListRowView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct ListRowView: View {
    let journal: Journal
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.journalTitle)
                    .font(.headline)
                Spacer()
            }
            Text(journal.journalText)
                .lineLimit(1)
        }
    }
}

#Preview {
    ListRowView(journal: Journal(id: 1, journalTitle: "title", journalText: "text", createdAt: "2024", journalImages: nil, userID: "user"))
}
