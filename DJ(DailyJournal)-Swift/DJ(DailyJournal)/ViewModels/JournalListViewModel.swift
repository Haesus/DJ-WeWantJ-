//
//  JournalListViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/6/24.
//

import Foundation
import Combine
import UIKit

class JournalListViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    @Published var albumImageViewModel = AlbumImageViewModel()
    @Published var todoListViewModel = TemplateViewModel<TodoTemplateModel>()
    @Published var dailyLogViewModel = TemplateViewModel<DailyTemplateModel>()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchJournals() {
        JournalService.shared.fetchJournals()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { documents in
                self.journals = documents
                if !documents.isEmpty {
                    print(documents[0])
                } else {
                    print("journals 없음.")
                }
            }.store(in: &cancellables)
    }
    
    func updateJournal(_ journal: UpdatedJournal) {
        JournalService.shared.updateJournal(journal)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Journal 업데이트 성공")
                case .failure(let error):
                    print("Journal 업데이트 실패\(error.localizedDescription)")
                }
            } receiveValue: { updatedJournal in
                if let index = self.journals.firstIndex(where: { $0.id == updatedJournal.id }) {
                    self.journals[index] = updatedJournal
                }
                print(updatedJournal)
            }.store(in: &cancellables)
    }
    
    func createJournalEntry() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, EEEE"
        let currentDate = dateFormatter.string(from: Date())
        
        albumImageViewModel.setPhotoLibraryImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let journalImages: [NewJournalImage]?
            if self.albumImageViewModel.imageArray.isEmpty {
                journalImages = nil
            } else {
                journalImages = self.albumImageViewModel.imageArray.map {
                    NewJournalImage(journalImageString: $0.jpegData(compressionQuality: 0.7)?.base64EncodedString() ?? "", journalID: 0)
                }
            }
            
            self.todoListViewModel.loadTemplate(templateName: "TodoTemplate.json")               
            self.dailyLogViewModel.loadTemplate(templateName: "DailyTemplate.json")
            
            let todoText = self.todoListViewModel.template?.todoList.map { $0.todoText }.joined(separator: "\n") ?? ""
            let dailyLogText = self.dailyLogViewModel.template?.dailyLogList.map { $0.dailyText }.joined(separator: "\n") ?? ""
            let combinedText = """
                    일정:
                    \(todoText)
                    
                    일지:
                    \(dailyLogText)
                    """
            
            let newJournal = CreatedJournal(
                journalTitle: currentDate,
                journalText: combinedText,
                createdAt: Date().description,
                journalImages: journalImages,
                userID: 1
            )
            
            JournalService.shared.saveJournal(newJournal)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Journal 생성 성공")
                    case .failure(let error):
                        print("Journal 생성 실패\(error.localizedDescription)")
                    }
                } receiveValue: { savedJournal in
                    self.journals.append(savedJournal)
                }.store(in: &self.cancellables)
        }
    }
}
