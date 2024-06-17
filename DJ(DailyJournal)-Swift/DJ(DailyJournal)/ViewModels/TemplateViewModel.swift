//
//  TemplateViewModel.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/7/24.
//

import Foundation

class TemplateViewModel<T: Codable>: ObservableObject {
    @Published var template: T?
    private var isLoaded = false
    
    func saveToJSON(fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            if let template = template {
                let data = try encoder.encode(template)
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentDirectory.appendingPathComponent(fileName)
                    try data.write(to: fileURL, options: .atomic)
                    print("JSON 파일 저장 성공: \(fileURL)")
                }
            } else {
                print("저장할 데이터가 없습니다.")
            }
        } catch {
            print("JSON 파일 저장 실패: \(error.localizedDescription)")
        }
    }
    
    func loadTemplate(templateName: String) {
        guard !isLoaded else { return }
        
        if let localTemplate = loadFromLocal(templateName) {
            self.template = localTemplate
            print("로컬에서 성공적으로 로드됨: \(localTemplate)")
        } else {
            let result: Result<T, Error> = load(filename: templateName)
            switch result {
                case .success(let template):
                    self.template = template
                    print("번들에서 성공적으로 로드됨: \(template)")
                case .failure(let error):
                    print("오류 발생: \(error.localizedDescription)")
            }
        }
        isLoaded = true
    }
    
    private func loadFromLocal(_ filename: String) -> T? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appendingPathComponent(filename)
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("로컬에서 로드 중 오류 발생: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func load(filename: String) -> Result<T, Error> {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            return .failure(NSError(domain: "FileError", code: 0, userInfo: [NSLocalizedDescriptionKey: "\(filename) 파일을 찾을 수 없습니다."]))
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            return .failure(error)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}
