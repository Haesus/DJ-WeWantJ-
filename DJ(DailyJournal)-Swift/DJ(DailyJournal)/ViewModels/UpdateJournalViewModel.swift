//
//  UpdateJournalViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/9/24.
//

import Foundation
import UIKit
import Combine

class UpdateJournalViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var journalText: String = ""
    @Published var journalImages: [UIImage?]?
    private var imageDataArray: [Data]?
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateJournal() {
        if let journalImages {
            imageDataArray = journalImages.compactMap { $0?.jpegData(compressionQuality: 0.3) }
        }
        
        let journal = UpdatedJournal(id: id, journalText: journalText, imageDataArray: imageDataArray)
        
        JournalService.shared.updateJournal(journal)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Journal 업데이트 성공")
                case .failure(let error):
                    print("Journal 업데이트 실패\n\(error.localizedDescription)")
                }
            } receiveValue: { updatedJournal in
                print(updatedJournal)
            }.store(in: &cancellables)
    }
}
