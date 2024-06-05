//
//  SignInView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject var signViewModel = SignViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                TextField(text: $signViewModel.userID) {
                    Text("아이디를 입력하세요.")
                        .foregroundStyle(Color.ivory)
                }
                
                SecureField(text: $signViewModel.password) {
                    Text("비밀번호를 입력하세요.")
                        .foregroundStyle(Color.ivory)
                }
                
                Button(action: {
                    signViewModel.signIn { success in
                        if success {
                            signViewModel.isSignedIn = true
                        }
                    }
                }, label: {
                    Text("SignIn")
                })
            }
        }
    }
}

#Preview {
    SignInView()
}
