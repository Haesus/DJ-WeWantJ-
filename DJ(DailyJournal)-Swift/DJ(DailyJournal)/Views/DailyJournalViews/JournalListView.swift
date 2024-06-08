//
//  ListView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct JournalListView: View {
    @EnvironmentObject var journalListViewModel: JournalListViewModel
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ivory]
    }
    
    var body: some View {
        NavigationSplitView {
            List(journalListViewModel.journals, id: \.id) { journal in
                NavigationLink(destination: DetailView(journal: journal)) {
                    ListRowView(journal: journal)
                }
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
