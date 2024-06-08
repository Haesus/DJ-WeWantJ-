//
//  SignUpViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/8/24.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var userNickName: String = ""
    @Published var userID: String = ""
    @Published var password: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    func signUp(completionHandler: @escaping (SignUpResponse)->Void){
        SignService.shared.signUp(userID: userID, userNickName: userNickName, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }  receiveValue: { signUpResponse in
                completionHandler(signUpResponse)
            }.store(in: &cancellable)
    }
}
