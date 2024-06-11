//
//  ListView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct JournalListView: View {
    @EnvironmentObject var journalListViewModel: JournalListViewModel
    @StateObject var journalViewModel = JournalViewModel()
    @StateObject var albumViewModel = AlbumImageViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Ivory") ?? UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Ivory") ?? UIColor.white]
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(journalListViewModel.journals, id: \.id) { journal in
                    NavigationLink(destination: JournalDetailView(journal: journal)) {
                        JournalListRowView(journal: journal)
                    }
                }
                .listRowBackground(Color.clear)
              
                Button(action: {
                    journalViewModel.saveJournal { result in
                        if result {
                            print("성공")
                        }
                    }
                }, label: {
                    Text("Button")
                })
            }
            .onAppear(perform: {
                journalListViewModel.fetchJournals()
                LocalNotificationHelper.shared.pushNotification(title: "일기를 작성할 시간이에요.", body: "지금 앱으로 들어가세요!!", hour: 11, minute: 00, identifier: "JOURNAL_TIME_NOTIFICATION")
            })
            .navigationTitle("Journals")
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor)
            .toolbar {
                Button(action: {
                    LocalNotificationHelper.shared.pushNotification(title: "알림", body: "알리미", seconds: 2, identifier: "PUSH_TEST")
                }, label: {
                    Text("알림")
                })
            }
        } detail: {
            Text("Navigation Split View")
        }
    }
}

#Preview {
    JournalListView()
        .environmentObject(JournalListViewModel())
}
