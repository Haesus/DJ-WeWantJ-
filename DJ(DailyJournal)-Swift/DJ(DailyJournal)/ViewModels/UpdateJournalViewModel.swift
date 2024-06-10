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
    @Published var journalTitle: String = ""
    @Published var journalText: String = ""
    @Published var journalImage: UIImage?
    //@Published var userID: Int = 0
    private var imageData: Data?
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateJournal(completionHandler: @escaping (Bool) -> Void) {
        if let journalImage {
            imageData = journalImage.jpegData(compressionQuality: 0.7)
        }
        
        let journal = UpdatedJournal(id: id, journalTitle: journalTitle, journalText: journalText, imageData: imageData)
        
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
                completionHandler(true)
            }.store(in: &cancellables)
    }
}
