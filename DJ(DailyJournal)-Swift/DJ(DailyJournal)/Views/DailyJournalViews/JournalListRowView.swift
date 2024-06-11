//
//  ListRowView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

let journal = Journal(id: 10, journalTitle: "일기 제목 수정", journalText: "오늘 사실 아주 많은 일이 있었습니다.", createdAt: "2024-06-05T02:18:35.000Z", journalImages: Optional([
    JournalImage(id: 1, journalImageString: "IMG_62451717514657152.JPG", journalID: 10),
    JournalImage(id: 2, journalImageString: "IMG_62451717514657152.JPG", journalID: 10),
    JournalImage(id: 3, journalImageString: "IMG_62451717514657152.JPG", journalID: 10),
    JournalImage(id: 4, journalImageString: "IMG_62451717514657152.JPG", journalID: 10)
]), userID: 3)

struct JournalListRowView: View {
    let journal: Journal
    var body: some View {
        VStack(alignment: .leading) {
            Text(journal.journalTitle)
                .font(.headline)
            Text(journal.journalText)
                .lineLimit(1)
        }
        .foregroundStyle(Color.ivory)
    }
}

#Preview {
    JournalListRowView(journal: journal)
}
