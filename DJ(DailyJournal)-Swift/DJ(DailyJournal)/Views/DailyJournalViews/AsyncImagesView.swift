//
//  AsyncImagesView.swift
//  DJ(DailyJournal)
//
//  Created by 한유진 on 6/10/24.
//

import SwiftUI

struct AsyncImagesView: View {
    let journal: Journal
    var isEditing: Bool
    @Binding var isPickerPresented: Bool
    
    var body: some View {
        HStack {
            if let hostKey = Bundle.main.hostKey, let journalImages = journal.journalImages {
                ForEach(journalImages, id: \.journalImageString) { image in
                    AsyncImage(url: URL(string: "https://\(hostKey)/images/\(image.journalImageString)")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .border(Color.gray)
                    .onTapGesture {
                        if isEditing {
                            isPickerPresented = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AsyncImagesView(journal: journal, isEditing: true, isPickerPresented: .constant(false))
}
