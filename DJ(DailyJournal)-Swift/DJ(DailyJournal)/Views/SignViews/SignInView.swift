//
//  SignInView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var signViewModel: SignViewModel
    @State private var showAlert = false
    @State private var responseMessage = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                TextField(text: $signViewModel.userID) {
                    Text("아이디를 입력하세요.")
                        .foregroundStyle(.gray)
                }
                .padding(.vertical)
                .padding(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .foregroundStyle(Color.ivory)
                
                SecureField(text: $signViewModel.password) {
                    Text("비밀번호를 입력하세요.")
                        .foregroundStyle(.gray)
                }
                .padding(.vertical)
                .padding(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .foregroundStyle(Color.ivory)
                
                Button(action: {
                    signViewModel.signIn { signInResponse in
                        if signInResponse.success {
                            signViewModel.isSignedIn = true
                        }
                        responseMessage = signInResponse.message
                        showAlert = true
                    }
                }, label: {
                    Text("SignIn")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                })
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .foregroundStyle(Color.ivory)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("로그인 결과"), message: Text(responseMessage), dismissButton: .default(Text("확인")))
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(SignViewModel())
}
