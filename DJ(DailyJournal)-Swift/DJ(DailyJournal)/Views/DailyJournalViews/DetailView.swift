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
    
    let journal: DailyJournal
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(journal: DailyJournal) {
        self.journal = journal
        _editedContent = State(initialValue: journal.content)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView {
                if isEditing {
                    TextEditor(text: $editedContent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineSpacing(0)
                } else {
                    Text(editedContent)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineSpacing(0)
                }
            }
            .frame(maxHeight: .infinity)
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
        editedContent = journal.content
        isEditing = false
    }
}

#Preview {
    NavigationView {
        DetailView(journal: DailyJournal.sampleData[0])
    }
}