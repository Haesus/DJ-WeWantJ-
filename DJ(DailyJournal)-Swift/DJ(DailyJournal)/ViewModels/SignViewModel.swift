//
//  SignViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import Combine
import SwiftUI

class SignViewModel: ObservableObject {
    @Published var userID: String = ""
    @Published var userNickName: String = ""
    @Published var password: String = ""
    @Published var isSignedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isSignedIn = SignService.shared.isSignedIn()
    }
    
    func signUp(completionHandler: @escaping (SignUpResponse) -> Void) {
        SignService.shared.signUp(userID: userID, userNickName: userNickName, password: password)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            } receiveValue: { signUpResponse in
                completionHandler(signUpResponse)
            }
            .store(in: &cancellables)
    }
    
    func signIn(completionHandler: @escaping (SignInResponse) -> Void) {
        SignService.shared.sign(userID: userID, password: password)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print(failure.localizedDescription)
                        print("SignViewModel sign method 실패")
                }
            } receiveValue: { response in
                print("""
                      가져온 정보
                      success: \(response.success)
                      token: \(response.token)
                      ducoment: \(response.document)
                      message: \(response.message)
                      """)
                completionHandler(response)
                if response.success {
                    SignService.shared.saveToken(response.token)
                }
            }
            .store(in: &cancellables)
    }
    
    func signOut() {
        let sign = SignService.shared
        sign.signOut()
        isSignedIn = sign.isSignedIn()
    }
}
