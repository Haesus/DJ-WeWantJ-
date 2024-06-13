//
//  LaunchScreen.swift
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
            
            GifImageView(name: "LaunchScreenGIF")
                .frame(width: 350, height: 650)
                .opacity(isActive ? 0 : 1)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 2)) {
                isActive = true
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
