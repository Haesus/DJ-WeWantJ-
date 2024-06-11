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
    @Published var albumImageViewModel = AlbumImageViewModel()
    @Published var eventStoreManager = EventStoreManager()
    @Published var todoListViewModel = TemplateViewModel<TodoTemplateModel>()
    @Published var dailyLogViewModel = TemplateViewModel<DailyTemplateModel>()
    
    var journalTitle: String = ""
    var journalText: String = ""
    var journalImage: [String] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    func saveJournal(completioHandler: @escaping (Bool)->Void) {
        Task {
            await albumImageViewModel.setPhotoLibraryImage()
            
            await eventStoreManager.requestAccess()
            
            todoListViewModel.loadTemplate(templateName: "TodoTemplate.json")
            dailyLogViewModel.loadTemplate(templateName: "DailyTemplate.json")
            
            if !albumImageViewModel.imageArray.isEmpty {
                for uiImage in albumImageViewModel.imageArray {
                    if let uiImageString = uiImage.jpegData(compressionQuality: 1)?.base64EncodedString() {
                        journalImage.append(uiImageString)
                    }
                }
            }
            
            if !eventStoreManager.events.isEmpty {
                for event in eventStoreManager.events {
                    journalText += event.title + "\n"
                }
                journalTitle = Date().todyaDate()
            } else {
                journalTitle = Date().todyaDate()
            }
            
            if let todoArray = todoListViewModel.template {
                for todoList in todoArray.todoList {
                    if todoList.isTodo {
                        journalText +=  "✅ "
                    } else {
                        journalText +=  "☑️ "
                    }
                    journalText += todoList.todoText + "\n"
                }
            }
            
            if let dailyArray = dailyLogViewModel.template {
                for dailyLogList in dailyArray.dailyLogList {
                    journalText += dailyLogList.isDaily + " " + dailyLogList.dailyText + "\n"
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
