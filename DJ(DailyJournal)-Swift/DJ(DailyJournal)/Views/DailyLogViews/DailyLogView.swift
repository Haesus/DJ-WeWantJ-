//
//  DailyLogView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

struct DailyLogView: View {
    @StateObject var dailyTemplateViewModel = TemplateViewModel<DailyTemplateModel>()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ivory]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                List {
                    // 수정된 부분: ForEach의 사용이 수정되었습니다.
                    if let dailyLogList = dailyTemplateViewModel.template?.dailyLogList {
                        ForEach(dailyLogList.indices, id: \.self) { index in
                            
                            DailyLogRowView(dailyTemplateViewModel: dailyTemplateViewModel, dailyTemplate: $dailyTemplateViewModel.template)
                                .listRowBackground(Color.clear)
                        }
                    }
                }
                .background(Color.backgroundColor)
                .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.lightYellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "plus")
                                    .foregroundColor(.ivory)
                                    .font(.system(size: 35, weight: .bold))
                            }
                        })
                        .padding(.bottom, 23)
                        .padding(.trailing, 23)
                    }
                }
            }
            .navigationTitle("Daily Log")
            .toolbar {
                Button(action: {
                    dailyTemplateViewModel.saveToJSON(fileName: "DailyTemplate.json")
                }, label: {
                    Text("수정")
                        .foregroundStyle(Color.lightYellow)
                })
            }
        }
        .onAppear(perform: { dailyTemplateViewModel.loadTemplate(templateName: "DailyTemplate.json")
        })
    }
}

#Preview {
    DailyLogView()
}
