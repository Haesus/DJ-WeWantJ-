//
//  SettingView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/11/24.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

struct SettingView: View {
    @ObservedObject var signViewModel = SignViewModel()
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SafariView(url: URL(string: "https://tagplayground.notion.site/70ca9d78786f4f529e3803c7bf59228e")!)) {
                    Text("서비스 이용약관")
                }
                
                NavigationLink(destination: SafariView(url: URL(string: "https://tagplayground.notion.site/70ca9d78786f4f529e3803c7bf59228e")!)) {
                    Text("개인정보 정책")
                }
                
                Button(action: {
                    showLogoutAlert = true
                }) {
                    Text("로그아웃")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("로그아웃"),
                        message: Text("로그아웃 하시겠어요?"),
                        primaryButton: .destructive(Text("확인"), action: {
                            signViewModel.signOut()
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
                
                NavigationLink(destination: Text("탈퇴하기")) {
                    Text("탈퇴하기")
                }
            }
            .navigationTitle("설정")
        }
    }
}

#Preview {
    SettingView()
}
