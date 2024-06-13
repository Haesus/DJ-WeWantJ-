//
//  GIFImageView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/13/24.
//

import SwiftUI
import SwiftyGif

struct GIFImageView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("GIF not found")
            return
        }
        
        do {
            let gifData = try Data(contentsOf: URL(fileURLWithPath: gifPath))
            let gif = try UIImage(gifData: gifData)
            uiView.setGifImage(gif)
        } catch {
            print("Failed to load GIF: \(error)")
        }
    }

    static func dismantleUIView(_ uiView: UIImageView, coordinator: ()) {
        uiView.clear()
    }
}

#Preview {
    GIFImageView(name: "LaunchScreenGIF")
}
