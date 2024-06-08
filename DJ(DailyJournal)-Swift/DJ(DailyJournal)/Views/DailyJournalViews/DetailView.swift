//
//  DetailView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct DetailView: View {
    @State private var isEditing = false
    @State private var editedContent: String
    
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
            ScrollView {
                if isEditing {
                    TextEditor(text: $editedContent)
                        .frame(maxWidth: .infinity, minHeight: screenHeight * 0.7, maxHeight: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineSpacing(0)
                } else {
                    Text(editedContent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineSpacing(0)
                }
            }
            Spacer()
        }
        .frame(width: screenWidth * 0.9)
        .border(Color.gray)
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
        .navigationTitle("Journal Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        isEditing = false
    }
    
    private func cancelEditing() {
        editedContent = journal.journalText
        isEditing = false
    }
}

#Preview {
    NavigationView {
        DetailView(journal: Journal(id: 1, journalTitle: "title", journalText: "text...", createdAt: "2024", journalImages: nil, userID: 3))
    }
}
