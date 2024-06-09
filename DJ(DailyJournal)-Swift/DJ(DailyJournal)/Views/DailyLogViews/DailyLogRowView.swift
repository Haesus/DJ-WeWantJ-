//
//  DailyLogRowView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

struct DailyLogRowView: View {
    @StateObject var dailyTemplateViewModel: TemplateViewModel<DailyTemplateModel>
    @Binding var dailyTemplate: DailyTemplateModel?
    
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            if let dailyLogList = dailyTemplate?.dailyLogList, index < dailyLogList.count {
                HStack {
                    TextField("Title", text: Binding(
                        get: {
                            dailyLogList[index].isDaily
                        },
                        set: { newValue in
                            dailyTemplateViewModel.template?.dailyLogList[index].isDaily = newValue
                        }))
                    .foregroundColor(.ivory)
                    .font(.title2)
                    
                    Text(" | ")
                        .font(.title)
                        .foregroundStyle(Color.ivory)
                    
                    TextField("내용 입력", text: Binding(
                        get: {
                            dailyLogList[index].dailyText
                        },
                        set: { newValue in
                            dailyTemplateViewModel.template?.dailyLogList[index].dailyText = newValue
                        }))
                    .foregroundColor(.ivory)
                    .font(.title2)
                }
                .background(Color.clear)
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    DailyLogRowView(dailyTemplateViewModel: TemplateViewModel(), dailyTemplate: .constant(DailyTemplateModel(dailyLogList: [DailyLog(isDaily: "", dailyText: "")])), index: 0)
}

