//
//  JournalService.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/5/24.
//

import Combine
import Foundation
import Alamofire

class JournalService {
    static let shared = JournalService()
    
    func saveJournal(_ journal: CreatedJournal) -> AnyPublisher<Journal, AFError>{
        guard let hostKey = Bundle.main.hostKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        guard let token = SignService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "https://\(hostKey)/journal/save"
        let header: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(String(journal.userID).data(using: .utf8)!, withName: "userID")
            multipartFormData.append(journal.journalTitle.data(using: .utf8)!, withName: "journalTitle")
            multipartFormData.append(journal.journalText.data(using: .utf8)!, withName: "journalText")
            //multipartFormData.append(journal.createdAt.data(using: .utf8)!, withName: "createdAt")
            //Data타입으로 변환
            if let images = journal.journalImages {
                for image in images {
                    if let imageData = Data(base64Encoded: image.journalImageString) {
                        multipartFormData.append(imageData, withName: "journalImages", fileName: "journalImage.jpg", mimeType: "image/jpeg")
                    }
                }
            }
        }, to: url, headers: header)
        .validate()
        .publishDecodable(type: JournalResponse.self)
        .value()
        .map { $0.documents[0] }
        .eraseToAnyPublisher()
    }
    
    // MARK: - JournalList
    func fetchJournals() -> AnyPublisher<[Journal], AFError> {
        guard let hostKey = Bundle.main.hostKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        guard let token = SignService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "https://\(hostKey)/journal/load"
        let header: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url, method: .get, headers: header)
            .responseDecodable(of: JournalResponse.self) { response in
                switch response.result {
                case .success(let journalResponse):
                    print("Decoding 성공")
                case .failure(let error):
                    if let data = response.data {
                        let json = String(data: data, encoding: .utf8) ?? "데이터 문자열 변환 에러"
                        print("Response data: \(json)")
                    }
                    print("Decoding error: \(error)")
                }
            }
            .publishDecodable(type: JournalResponse.self)
            .value()
            .map { $0.documents }
            .eraseToAnyPublisher()
    }
    
    // MARK: - JournalUpdate
    func updateJournal(_ journal: UpdatedJournal) -> AnyPublisher<Journal, AFError> {
        guard let hostKey = Bundle.main.hostKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        guard let token = SignService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "https://\(hostKey)/journal/\(journal.id)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        print("Request URL: \(url)")
        print("Authorization Token: \(token)")
        
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(journal.journalText.data(using: .utf8)!, withName: "journalText")
//            if let imageData = journal.imageData {
//                multipartFormData.append(imageData, withName: "journalImage", fileName: "journalImage.jpg", mimeType: "image/jpeg")
//            }
        }, to: url, method: .patch, headers: headers)
        .validate()
        .publishDecodable(type: JournalResponse.self)
        .value()
        .map { $0.documents[0] }
        .eraseToAnyPublisher()
    }
}
