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
    @Published var albumImageViewModel = AlbumImageViewModel()
    
    @Published var journalImage: [String] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    func saveJournal(completioHandler: @escaping (Bool)->Void) {
        Task {
            await albumImageViewModel.setPhotoLibraryImage()
            
            if !albumImageViewModel.imageArray.isEmpty {
                for uiImage in albumImageViewModel.imageArray {
                    if let uiImageString = uiImage.jpegData(compressionQuality: 1)?.base64EncodedString() {
                        journalImage.append(uiImageString)
                    }
                }
            }
            
            let journal = JournalRequest(journalTitle: journalTitle, journalText: journalText, journalImageStringArray: journalImage)
            
            JournalService.shared.saveJournal(journal)
                .sink { completion in
                    print(completion)
                    switch completion {
                        case .finished:
                            break
                        case.failure(let error):
                            print(error.localizedDescription)
                    }
                } receiveValue: { journal in
                    completioHandler(true)
                }.store(in: &cancellable)
        }
    }
}
