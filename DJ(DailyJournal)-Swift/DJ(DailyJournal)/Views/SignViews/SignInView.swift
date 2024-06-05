//
//  SignInView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/4/24.
//

import SwiftUI

struct SignInView: View {
    @State var userID: String
    @State var password: String
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                TextField(text: $userID) {
                    Text("아이디를 입력하세요.")
                        .foregroundStyle(Color.ivory)
                }
                
                SecureField(text: $password) {
                    Text("비밀번호를 입력하세요.")
                        .foregroundStyle(Color.ivory)
                }
                
                Button(action: {
                    
                }, label: {
                    Text("SignIn")
                })
            }
        }
    }
}

#Preview {
    SignInView(userID: "", password: "")
}
