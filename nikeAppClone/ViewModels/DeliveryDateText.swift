//
//  DeliveryDateText.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/29/26.
//

import SwiftUI

var deliveryDateText: String {
    let calendar = Calendar.current
    let today = Date()

    let startDate = calendar.date(byAdding: .day, value: 3, to: today)!
    let endDate = calendar.date(byAdding: .day, value: 5, to: today)!

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateFormat = "EEE, d MMM"

    return "Arrives \(formatter.string(from: startDate))\nto \(formatter.string(from: endDate))"
}
