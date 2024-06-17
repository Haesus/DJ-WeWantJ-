//
//  SummarySettingView.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/13/24.
//

import SwiftUI

struct SummarySettingView: View {
    @AppStorage("aiResponse") private var selectedChoice: String?
    let choices = ["랩", "발라드", "팝송", "트로트"]
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                List {
                    ForEach(choices, id: \.self) { choice in
                        HStack {
                            Text(choice)
                                .padding()
                                .cornerRadius(8)
                            
                            Spacer()
                            
                            if selectedChoice == choice {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .foregroundColor(selectedChoice == choice ? .ivory : .gray)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedChoice = choice
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .background(Color.clear)
        }
        .navigationTitle("요약 형태 설정")
    }
}

#Preview {
    SummarySettingView()
}
