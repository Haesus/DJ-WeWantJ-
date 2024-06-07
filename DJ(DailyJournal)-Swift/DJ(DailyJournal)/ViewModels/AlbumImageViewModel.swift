//
//  AlbumImageViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI
import PhotosUI
import Photos

class ImageManager: ObservableObject {
    @Published var imageArray: [UIImage] = []
    
    static let shared = ImageManager()
    private let imageManager = PHImageManager()
    
    func setPhotoLibraryImage() -> [PHAsset] {
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = 2
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchPhotos = PHAsset.fetchAssets(with: fetchOption)
        print("fetchPhotos: \(fetchPhotos)")
        var assets: [PHAsset] = []
        
        // 가져온 이미지를 배열에 추가
        fetchPhotos.enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        
        print("assets: \(assets)")
        print(assets.count)
        return assets
    }
    
    func requestImage(from assets: [PHAsset], thumnailSize: CGSize) {
        for asset in assets {
            print("asset: \(asset)")
            self.imageManager.requestImage(for: asset, targetSize: thumnailSize, contentMode: .aspectFill, options: nil) { image, info in
                // 수정해야 될 부분
                print(self.imageArray)
                self.imageArray.append(image!)
            }
        }
    }
}

func fetchAllPhotosMetadata() {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)] // 사진을 생성 날짜 기준으로 정렬
    
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) // 모든 이미지 가져오기
    
    print(fetchResult)
    fetchResult.enumerateObjects { (asset, _, _) in
        // 각각의 사진에 대해 메타데이터 확인
        if let creationDate = asset.creationDate {
            print("Creation Date:", creationDate)
        }
        print("localIdentifier:", asset.localIdentifier)
        //        if let localIdentifier = asset.localIdentifier {
        //            print("localIdentifier:", localIdentifier)
        //        }
    }
}

class AlbumImageViewModel {
    
}

struct PHCaptureImageView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PHCaptureImageView>) -> PHPickerViewController {
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        configuration.filter = .any(of: [.images])
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PHCaptureImageView>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let view: PHCaptureImageView
        
        init(_ parent: PHCaptureImageView) {
            self.view = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard !results.isEmpty else {
                return
            }
            let imageResult = results[0]
            
            guard imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                return
            }
            
            if imageResult.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                imageResult.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
                    guard let data = data,
                          let cgImageSource = CGImageSourceCreateWithData(data as CFData, nil),
                          let properties = CGImageSourceCopyPropertiesAtIndex(cgImageSource, 0, nil) as? Dictionary<String, Any>,
                          let exif = properties["{Exif}"],
                          let dictionary = exif as? Dictionary<String, Any>
                    else {
                        print("error")
                        return
                    }
                    //                    let exif1 = properties[kCGImagePropertyExifDictionary as String] as? [String: Any],
                    //                    let localIdentifier = exif1["LocalIdentifier"] as? String,
                    //                    print("exif1: \(exif1)")
                    //                    print(localIdentifier)
                    print("dictionary: \(dictionary)")
                    imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage: NSItemProviderReading?, error: Error?) in
                        // 선택한 Image를 Load해 수행할 명령
                    }
                }
            }
        }
    }
}
