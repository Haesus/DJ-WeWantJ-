//
//  DailyLogRowView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

struct DailyLogRowView: View {
    @Binding var logItem: LogItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(" | ")
                TextField("내용 입력", text: $logItem.text)
            }
            .foregroundStyle(Color.ivory)
            .font(.title2)
        }
    }
}


#Preview {
    DailyLogRowView(logItem: .constant(LogItem()))
}
