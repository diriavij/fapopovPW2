//
//  CalendarService.swift
//  fapopovPW2
//
//  Created by Фома Попов on 03.12.2024.
//

import Foundation
import EventKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel {
    var title: String
    var startDate: Date
    var endDate: Date
    var note: String?
}
