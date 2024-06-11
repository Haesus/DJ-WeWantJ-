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
    @State private var isPickerPresented = false
    @State private var selectedImages: [UIImage?] = Array(repeating: nil, count: 4)
    @Environment(\.dismiss) var dismiss
    @State var photoIndex: Int = 0
    @State var isPhotoChanged = false
    
    let journal: Journal
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    init(journal: Journal) {
        self.journal = journal
        _editedContent = State(initialValue: journal.journalText)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text(journal.journalTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack {
                    if let hostKey = Bundle.main.hostKey,
                       let journalImages = journal.journalImages {
                        ForEach(0..<4) { index in
                            if let seletedImage = selectedImages[index] {
                                Image(uiImage: seletedImage)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipped()
                            } else {
                                AsyncImage(url: URL(string: "https://\(hostKey)/images/\(journalImages[index].journalImageString)")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                                .border(Color.black)
                                .onTapGesture {
                                    if isEditing {
                                        isPickerPresented = true
                                        isPhotoChanged = true
                                        photoIndex = index
                                    }
                                }
                            }
                        }
                    }
                }
                
                if isEditing {
                    TextEditor(text: $updateJournalViewModel.journalText)
                        .frame(maxWidth: .infinity, minHeight: screenHeight * 0.5, maxHeight: .infinity, alignment: .leading)
                        .lineSpacing(0)
                        .scrollContentBackground(.hidden)
                    
                } else {
                    Text(editedContent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 5)
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
            .foregroundStyle(Color.ivory)
            .navigationTitle("Journal Detail")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.updateJournalViewModel.id = journal.id
                self.updateJournalViewModel.journalText = journal.journalText
            }
            .sheet(isPresented: $isPickerPresented, content: {
                ImagePicker(image: $selectedImages[photoIndex])
        })
        }
    }
    
    private func saveChanges() {
        if isPhotoChanged {
            for index in 0..<4 {
                if let selectedImage = selectedImages[index] {
                    updateJournalViewModel.journalImages[index] = selectedImage
                } else if let hostKey = Bundle.main.hostKey,
                          let journalImages = journal.journalImages {
                    let imageURLString = "https://\(hostKey)/images/\(journalImages[index].journalImageString)"
                    if let imageURL = URL(string: imageURLString) {
                        fetchImage(from: imageURL) { image in
                            DispatchQueue.main.async {
                                if let image = image {
                                    updateJournalViewModel.journalImages[index] = image
                                } else {
                                    print("Failed to load image from URL: \(imageURLString)")
                                }
                            }
                        }
                    }
                }
            }
        }
        
        updateJournalViewModel.updateJournal {
            if $0 { }
        }
        
        editedContent = updateJournalViewModel.journalText
        isEditing = false
    }
    
    private func cancelEditing() {
        editedContent = journal.journalText
        isEditing = false
        //selectedImage = nil
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                let image = UIImage(data: data)
                completion(image)
            } else {
                print("Error fetching image: \(String(describing: error))")
                completion(nil)
            }
        }.resume()
    }
    
}

#Preview {
    NavigationView {
        JournalDetailView(journal: journal)
    }
}
