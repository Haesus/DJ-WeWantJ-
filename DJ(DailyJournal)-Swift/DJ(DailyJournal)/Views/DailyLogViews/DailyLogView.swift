//
//  DailyLogView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

struct DailyLogView: View {
    @StateObject var dailyTemplateViewModel = TemplateViewModel<DailyTemplateModel>()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ivory]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                List {
                    if let dailyLogList = dailyTemplateViewModel.template?.dailyLogList {
                        ForEach(dailyLogList.indices, id: \.self) { index in
                            DailyLogRowView(dailyTemplateViewModel: dailyTemplateViewModel, dailyTemplate: $dailyTemplateViewModel.template, index: index)
                                .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: removeRows)
                    }
                }
                .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: addDailyLogTemplate, label: {
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
        .onAppear(perform: { dailyTemplateViewModel.loadTemplate(templateName: "DailyTemplate.json") })
    }
    
    private func addDailyLogTemplate() {
        dailyTemplateViewModel.template?.dailyLogList.append(DailyLog(isDaily: "", dailyText: ""))
    }
    
    private func removeRows(at offsets: IndexSet) {
        dailyTemplateViewModel.template?.dailyLogList.remove(atOffsets: offsets)
    }
}

#Preview {
    DailyLogView()
}
