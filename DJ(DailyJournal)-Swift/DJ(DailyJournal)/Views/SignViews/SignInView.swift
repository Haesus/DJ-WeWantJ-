//
//  SignInView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            Text("test")
                .foregroundStyle(Color.ivory)
        }
        .padding()
        
            .background(
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
            )
//        .background(Color.backgroundColor.ignoresSafeArea())
    }
}

#Preview {
    SignInView()
}
