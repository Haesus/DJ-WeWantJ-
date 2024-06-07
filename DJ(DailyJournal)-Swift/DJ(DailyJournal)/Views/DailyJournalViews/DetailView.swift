//
//  DetailView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct DetailView: View {
    let journal: DailyJournal
    private let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title)
                .fontWeight(.bold)
                Spacer()
            }
            Text(journal.content)
            Spacer()
        }
        .frame(width: screenWidth * 0.8)
        .border(Color.gray)
    }
}

#Preview {
    DetailView(journal: DailyJournal.sampleData[0])
}
