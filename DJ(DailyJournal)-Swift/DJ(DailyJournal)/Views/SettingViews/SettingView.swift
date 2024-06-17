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
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var signViewModel: SignViewModel
    @State private var showLogoutAlert = false
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            List {
                NavigationLink {
                    SummarySettingView()
                } label: {
                    Text("요약 형태 설정")
                }
                
                NavigationLink(destination: SafariView(url: URL(string: "https://tagplayground.notion.site/70ca9d78786f4f529e3803c7bf59228e")!)) {
                    Text("개인정보 정책 및 서비스 이용약관")
                }
                
                NavigationLink(destination: SafariView(url: URL(string: "https://tagplayground.notion.site/9ab7b734864a4d1bba681e3c52bde34f?v=5908c97718664315b2c31bca9f3304d8&pvs=4")!)) {
                    Text("개발자 정보")
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
                            self.presentationMode.wrappedValue.dismiss()
                            signViewModel.signOut()
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            
            //                NavigationLink(destination: SignInView().environmentObject(signViewModel), isActive: $isLoggedOut) {
            //                    EmptyView()
            //                }
            //                .hidden()
        }
        .navigationTitle("설정")
    }
}

#Preview {
    SettingView().environmentObject(SignViewModel())
}
