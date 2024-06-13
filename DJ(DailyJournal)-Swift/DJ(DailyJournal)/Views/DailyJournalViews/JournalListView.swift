//
//  ListView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct JournalListView: View {
    @EnvironmentObject var signViewModel : SignViewModel
    @StateObject var journalListViewModel = JournalListViewModel()
    @StateObject var journalViewModel = JournalViewModel()
    @StateObject var albumViewModel = AlbumImageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(journalListViewModel.journals, id: \.id) { journal in
                    NavigationLink(destination: JournalDetailView(journal: journal)
                        .environmentObject(journalListViewModel)) {
                            JournalListRowView(journal: journal)
                        }
                        .listRowBackground(Color.clear)
                }
                .refreshable {
                    journalListViewModel.fetchJournals()
                }
                .navigationBarTitle("Journals", displayMode: .large)
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Ivory") ?? UIColor.white]
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Ivory") ?? UIColor.white]
                }
            }
            .onAppear(perform: {
                journalListViewModel.fetchJournals()
                LocalNotificationHelper.shared.pushNotification(title: "일기를 작성할 시간이에요.", body: "지금 앱으로 들어가세요!!", hour: 23, minute: 00, identifier: "JOURNAL_TIME_NOTIFICATION")
            })
            .navigationTitle("Journals")
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor)
            .toolbar {
                NavigationLink {
                    SettingView()
                        .environmentObject(signViewModel)
                } label: {
                    Image(systemName: "gear")
                }

                Button(action: {
                    LocalNotificationHelper.shared.pushNotification(title: "알림", body: "알리미", seconds: 2, identifier: "PUSH_TEST")
                }, label: {
                    Text("알림")
                })
            }
        }
    }
}

#Preview {
    JournalListView()
}
