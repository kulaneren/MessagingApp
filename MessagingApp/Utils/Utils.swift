//
//  Utils.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import Foundation

class Utils {

    static func hourMinFromDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return String(format: "%d:%d", hour, minute)
    }

    static func getCurrentHourMinute() -> String {
        let date = Date()
        return Utils.hourMinFromDate(date)
    }

}
