//
//  DetailView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/7/24.
//

import SwiftUI

struct DetailView: View {
    let journal: DailyJournal
    private let screenWidth = UIScreen.main.bounds.width
    @State private var isEditing = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Text(journal.content)
            Spacer()
        }
        .frame(width: screenWidth * 0.8)
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
        isEditing = false
    }
}

#Preview {
    NavigationView {
        DetailView(journal: DailyJournal.sampleData[0])
    }
}
