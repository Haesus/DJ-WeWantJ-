//
//  ImageTestView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI
//import UIKit

struct ImageTestView: View {
    @StateObject var imageManager = ImageManager()
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack {
            List(imageManager.imageArray, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
            
            Button("앨범에서 이미지 선택") {
                imageManager.requestImage(from: imageManager.setPhotoLibraryImage(), thumnailSize: CGSize(width: 100.0, height: 100.0))
                //                fetchAllPhotosMetadata()
                //                isShowingImagePicker = true
            }
            .padding()
        }
        //        .sheet(isPresented: $isShowingImagePicker) {
        //            PHCaptureImageView(selectedImage: $selectedImage)
        //        }
    }
}

#Preview {
    ImageTestView()
}
