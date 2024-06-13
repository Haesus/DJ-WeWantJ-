//
//  LaunchScreenView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/13/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                GIFImageView(name: "LaunchScreenGIF")
                    .frame(width: 350, height: 650)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                Spacer()
            }
            .opacity(isActive ? 0 : 1)
        
        }
    }
}



#Preview {
    LaunchScreenView()
}
