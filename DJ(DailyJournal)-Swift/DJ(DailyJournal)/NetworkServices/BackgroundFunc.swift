//
//  BackgroundFunc.swift
//  DJ(DailyJournal)
//
//  Created by 윤해수 on 6/10/24.
//

import BackgroundTasks
import Foundation
    
func scheduleAppRefresh() {
    let a = BGProcessingTaskRequest(identifier: "myapprefresh")
    let request = BGAppRefreshTaskRequest(identifier: "myapprefresh")
    a.earliestBeginDate = Date().addingTimeInterval(1)
    try? BGTaskScheduler.shared.submit(a)
}
