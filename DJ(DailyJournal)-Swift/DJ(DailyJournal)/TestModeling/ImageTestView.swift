//
//  ImageTestView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI

struct ImageTestView: View {
    @StateObject var albumImageViewModel = AlbumImageViewModel()
    
    var body: some View {
        VStack {
            List(albumImageViewModel.imageArray, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
            
            Button("앨범에서 이미지 선택") {
                albumImageViewModel.setPhotoLibraryImage()
            }
            .padding()
        }
    }
}

#Preview {
    ImageTestView()
}
