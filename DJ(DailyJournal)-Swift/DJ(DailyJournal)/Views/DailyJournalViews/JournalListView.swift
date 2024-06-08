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
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                List(journalListViewModel.journals, id: \.id) { journal in
                    NavigationLink(destination: DetailView(journal: journal)) {
                        ListRowView(journal: journal)
                    }
                }
                .navigationTitle("Journals")
                .onAppear(perform: {
                    journalListViewModel.fetchJournals()
                    print(journalListViewModel.journals)
            })
            }
        }
    }
}

#Preview {
    JournalListView()
        .environmentObject(JournalListViewModel())
}
