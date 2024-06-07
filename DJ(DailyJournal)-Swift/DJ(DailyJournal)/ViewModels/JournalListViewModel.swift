//
//  JournalListViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/6/24.
//

import Foundation
import Combine

class JournalListViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchJournals() {
        JournalService.shared.fetchJournals()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { documents in
                self.journals = documents
                print(documents[0])
            }.store(in: &cancellables)
    }
}
