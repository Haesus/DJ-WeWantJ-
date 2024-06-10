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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ivory]
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(journalListViewModel.journals, id: \.id) { journal in
                    NavigationLink(destination: JournalDetailView(journal: journal)) {
                        JournalListRowView(journal: journal)
                    }
                }
                
                Button(action: {
                    journalViewModel.journalText = "Text String"
                    journalViewModel.journalTitle = "TitleString"
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
            })
            .navigationTitle("Journals")
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor)
        } detail: {
            Text("Navigation Split View")
        }
        
    }
}

#Preview {
    JournalListView()
        .environmentObject(JournalListViewModel())
}
