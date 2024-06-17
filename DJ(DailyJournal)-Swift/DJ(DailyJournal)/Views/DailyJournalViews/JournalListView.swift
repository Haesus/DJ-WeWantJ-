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
    @StateObject var albumImageViewModel = AlbumImageViewModel()
    @StateObject var eventStoreManager = EventStoreManager()
    
    var body: some View {
        NavigationView {
            VStack {
                List(journalListViewModel.journals.sorted(by: { $0.id > $1.id }), id: \.id) { journal in
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
                Task {
                    await albumImageViewModel.setPhotoLibraryImage()
                    await eventStoreManager.requestAccess()
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
//                    LocalNotificationHelper.shared.pushNotification(title: "일기 작성 시간", body: "일기를 작성할 시간이에요. DJ가 대신 써드리겠습니다.", seconds: 2, identifier: "PUSH_TEST")
//                }
                journalListViewModel.fetchJournals()
                LocalNotificationHelper.shared.pushNotification(title: "일기를 작성할 시간이에요.", body: "지금 앱으로 들어가세요!!", hour: 23, minute: 00, identifier: "JOURNAL_TIME_NOTIFICATION")
            })
            .navigationTitle("Journals")
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor)
            .toolbar {
                Button(action: {
                    LocalNotificationHelper.shared.pushNotification(title: "일기 작성 시간", body: "일기를 작성할 시간이에요. DJ가 대신 써드리겠습니다.", seconds: 2, identifier: "PUSH_TEST")
                }, label: {
                    Text("     ")
                })
                NavigationLink {
                    SettingView()
                        .environmentObject(signViewModel)
                } label: {
                    Image(systemName: "gear")
                }

            }
        }
    }
}

#Preview {
    JournalListView()
}
