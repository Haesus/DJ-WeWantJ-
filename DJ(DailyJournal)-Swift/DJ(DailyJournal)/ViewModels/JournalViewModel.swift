//
//  JournalViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/6/24.
//

import Foundation
import UIKit
import Combine

class JournalViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var journalTitle: String = ""
    @Published var journalText: String = ""
    @Published var journalImages: UIImage?
    @Published var userID: Int = 0
    @Published var createdAt: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    func saveJournal(completioHandler: @escaping (Bool)->Void) {
        if journalImages == nil {
            self.journalImages = UIImage(systemName: "journalImages")
        }
        
        // UIImage를 JournalImage로 변환
        let imageString = journalImages?.jpegData(compressionQuality: 0.7)?.base64EncodedString() ?? ""
        let journalImage = NewJournalImage(journalImageString: imageString, journalID: id)

        // !!!: 6/7 let journal = Journal(...) --> CreatedJournal(...)
        let journal = CreatedJournal(journalTitle: journalTitle, journalText: journalText, createdAt: createdAt, journalImages: [journalImage], userID: userID)
        
        JournalService.shared.saveJournal(journal)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { journal in
                completioHandler(true)
                print(journal.journalImages as Any)
            }.store(in: &cancellable)
    }
}
