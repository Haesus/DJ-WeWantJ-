//
//  DetailView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct JournalDetailView: View {
    @StateObject var updateJournalViewModel = UpdateJournalViewModel()
    @State private var isEditing = false
    @State private var editedContent: String
    @State var isPickerPresented = false
    @Environment(\.dismiss) var dismiss
    
    let journal: Journal
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(journal: Journal) {
        self.journal = journal
        _editedContent = State(initialValue: journal.journalText)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.journalTitle)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            if let hostKey = Bundle.main.hostKey,
               let imageString = journal.journalImages?[0].journalImageString {
                AsyncImage(url: URL(string: "https://\(hostKey)/images/\(imageString)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .border(Color.gray)
                .onTapGesture {
                    if isEditing {
                        isPickerPresented = true
                    }
                }
            }
            
            if isEditing {
                TextEditor(text: $updateJournalViewModel.journalText)
                    .frame(maxWidth: .infinity, minHeight: screenHeight * 0.6, maxHeight: .infinity, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .lineSpacing(0)
                
            } else {
                Text(editedContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .lineSpacing(0)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Save") {
                        saveChanges()
                    }
                } else {
                    Button("Edit") {
                        isEditing.toggle()
                    }
                }
            }
            if isEditing {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        cancelEditing()
                    }
                }
            }
        }
        .frame(width: screenWidth * 0.9)
        .border(Color.gray)
        .navigationTitle("Journal Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            self.updateJournalViewModel.id = journal.id
            self.updateJournalViewModel.journalText = journal.journalText
            //self.updateJournalViewModel.journalImages = journal.journalImages
        })
        .sheet(isPresented: $isPickerPresented, content: {
            ImagePicker(image: $updateJournalViewModel.journalImage)
        })
    }
    
    private func saveChanges() {
        updateJournalViewModel.updateJournal {
            if $0 { dismiss() }
        }
        editedContent = updateJournalViewModel.journalText
        isEditing = false
    }
    
    private func cancelEditing() {
        editedContent = journal.journalText
        isEditing = false
    }
}

#Preview {
    NavigationView {
        JournalDetailView(journal: journal)
    }
}
