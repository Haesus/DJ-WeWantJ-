//
//  SignService.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/5/24.
//

import Combine
import Foundation
import Alamofire

class SignService {
    static let shared = SignService()
    let tokenKey = "token"
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func isSignedIn() -> Bool {
        getToken() != nil
    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    func signIn(userID: String, password: String) -> AnyPublisher<SignInResponse, AFError> {
        guard let hostKey = Bundle.main.hostKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "https://\(hostKey)/sign/signIn"
        let parameters: Parameters = ["userID": userID, "password": password]
        
        return Future<SignInResponse, AFError> { promise in
            AF.request(url, method: .post, parameters: parameters).responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                    case .success(let result):
                        print("App Service와 통신 성공, 디코딩 성공적")
                        promise(.success(result))
                    case .failure(let failure):
                        print("App Service와 통신 실패 혹은 디코딩 실패")
                        promise(.failure(failure))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp(userID: String, userNickName: String, password: String) -> AnyPublisher<SignUpResponse, AFError> {
        guard let hostKey = Bundle.main.hostKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let url = "https://\(hostKey)/sign/signUp"
        let parameters: [String: Any] = ["userID": userID, "userNickName": userNickName, "password": password]
        
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .publishDecodable(type: SignUpResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
