//
//  AlbumImageViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import SwiftUI
import Photos

class AlbumImageViewModel: ObservableObject {
    @Published var imageArray: [UIImage] = []
    
    func setPhotoLibraryImage() async {
        let fetchPhotos = fetchOptionsAssets(limit: 4, sortAscending: false)
        var fetchedImages: [UIImage] = []
        
        await withCheckedContinuation { continuation in
            let group = DispatchGroup()
            
            fetchPhotos.enumerateObjects { asset, _, _ in
                if let creationDate = asset.creationDate {
                    let todayDate = Date()
                    if creationDate.isSameDay(as: todayDate) {
                        group.enter()
                        self.requestImage(from: asset, thumnailSize: CGSize(width: 100.0, height: 100.0)) { image in
                            if let image = image {
                                fetchedImages.append(image)
                            }
                        }
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                self.imageArray = fetchedImages
                continuation.resume()
            }
        }
    }
    
    private func fetchOptionsAssets(limit: Int, sortAscending: Bool) -> PHFetchResult<PHAsset> {
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = limit
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: sortAscending)]
        return PHAsset.fetchAssets(with: fetchOption)
    }
    
    private func requestImage(from asset: PHAsset, thumnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        let imageManager = PHImageManager()
        imageManager.requestImage(for: asset, targetSize: thumnailSize, contentMode: .aspectFill, options: nil) { image, info in
            completion(image)
        }
    }
}
