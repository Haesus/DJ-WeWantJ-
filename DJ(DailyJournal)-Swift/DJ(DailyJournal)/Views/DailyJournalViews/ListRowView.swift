//
//  ListRowView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct ListRowView: View {
    let journal: DailyJournal
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.headline)
                Spacer()
            }
            Text(journal.content)
                .lineLimit(1)
        }
    }
}

#Preview {
    ListRowView(journal: DailyJournal.sampleData[0])
}
