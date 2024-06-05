//
//  DailyLogView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/4/24.
//

import SwiftUI

struct DailyLogView: View {
    @State private var logItems: [LogItem] = []
    
    var body: some View {
        ZStack {
            
            List {
                ForEach($logItems) { $logItem in
                    DailyLogRowView(logItem: $logItem)
                        .listRowBackground(Color.clear)
                }
                .onDelete(perform: removeRows)
            }
            .background(Color.backgroundColor)
            .scrollContentBackground(.hidden)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        addLogItem()
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
    }
    private func addLogItem() {
        logItems.append(LogItem())
    }

    private func removeRows(at offsets: IndexSet) {
        logItems.remove(atOffsets: offsets)
    }
}

#Preview {
    DailyLogView()
}
