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
    
    // !!!: 6/7 func saveJournal(_ journal: Journal) --> func saveJournal(_ journal: CreatedJournal)
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
            // MARK: 코드 보수 - id field 삭제, Journal 모델 Identifiable 프로토콜 적용할까요? @haneujeen
            //multipartFormData.append(journal.id.data(using: .utf8)!, withName: "id")
            multipartFormData.append(journal.userID.data(using: .utf8)!, withName: "userID")
            multipartFormData.append(journal.journalTitle.data(using: .utf8)!, withName: "journalTitle")
            multipartFormData.append(journal.journalText.data(using: .utf8)!, withName: "journalText")
            multipartFormData.append(journal.createdAt.data(using: .utf8)!, withName: "createdAt")
            //Data타입으로 변환
            if let images = journal.journalImages {
                for image in images {
                    if let imageData = Data(base64Encoded: image.journalImageString) {
                        multipartFormData.append(imageData, withName: "journalImages", fileName: "journalImage.jpg", mimeType: "image/jpeg")
                    }
                }
            }
        }, to: url, headers: header)
        .validate() // 유효성 검사
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
            .publishDecodable(type: JournalResponse.self)
            .value()
            .map { $0.documents }
            .eraseToAnyPublisher()
    }
    
    // MARK: - JournalUpdate
        func updateJournal(_ journal: Journal) -> AnyPublisher<Journal, AFError> {
            guard let hostKey = Bundle.main.hostKey else {
                print("API 키를 로드하지 못했습니다.")
                return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
            }
            
            guard let token = SignService.shared.getToken() else {
                return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
            }
            
            let url = "https://\(hostKey)/journal/:id"
            let header: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            
            return AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(journal.id.data(using: .utf8)!, withName: "id")
                multipartFormData.append(journal.userID.data(using: .utf8)!, withName: "userID")
                multipartFormData.append(journal.journalTitle.data(using: .utf8)!, withName: "journalTitle")
                multipartFormData.append(journal.journalText.data(using: .utf8)!, withName: "journalText")
                multipartFormData.append(journal.createdAt.data(using: .utf8)!, withName: "createdAt")
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
}
