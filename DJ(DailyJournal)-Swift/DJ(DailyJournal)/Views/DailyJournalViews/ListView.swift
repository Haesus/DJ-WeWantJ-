//
//  ListView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct ListView: View {
    let journals: [DailyJournal]
    var body: some View {
        NavigationStack {
            List(journals) { journal in
                NavigationLink(destination: DetailView(journal: journal)) {
                    ListRowView(journal: journal)
                }
            }
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Title")
        }
    }
}

#Preview {
    ListView(journals: DailyJournal.sampleData)
}
