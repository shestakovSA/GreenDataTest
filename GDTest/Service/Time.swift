//
//  Time.swift
//  GDTest
//
//  Created by Сергей Шестаков on 16.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

class Time {
    
    func dateFormater(dataOne: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        let date: Date? = dateFormatterGet.date(from: dataOne)
        return(dateFormatter.string(from: date!))
    }

    func timeDecoder(gmt: String) -> String {
        let UTCDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(identifier:"GMT" + gmt)
        return formatter.string(from: UTCDate)
    }
}
