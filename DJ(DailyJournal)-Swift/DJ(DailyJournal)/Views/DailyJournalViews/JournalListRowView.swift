//
//  ListRowView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI
let journal = Journal(id: 10, journalTitle: "일기 제목 수정", journalText: "오늘 사실 아주 많은 일이 있었습니다.", createdAt: "2024-06-05T02:18:35.000Z", journalImages: Optional([JournalImage(id: 9, journalImageString: "IMG_62451717514657152.JPG", journalID: 10)]), userID: 3)

struct JournalListRowView: View {
    let journal: Journal
    var body: some View {
        VStack(alignment: .leading) {
            if let hostKey = Bundle.main.hostKey,
               let imageString = journal.journalImages?[0].journalImageString {
                AsyncImage(url: URL(string: "https://\(hostKey)/images/\(imageString)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .border(Color.gray)
            }
            
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
    JournalListRowView(journal: journal)
}