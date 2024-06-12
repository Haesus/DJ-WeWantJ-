//
//  SettingRowView.swift
//  DJ(DailyJournal)
//
//  Created by 김수영 on 6/11/24.
//

import SwiftUI

struct SettingRowView: View {
    var body: some View {
        VStack {
            List {
                Text("계정정보")
                Text("로그아웃")
                Text("계정탈퇴")
            }
            
            List {
                Text("서비스 이용약관")
            }
        }
    }
}

#Preview {
    SettingRowView()
}
