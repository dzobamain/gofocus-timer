//
//  CalendarState.swift
//  macos
//

import Foundation
import Combine

class CalendarState: ObservableObject
{
    @Published var selectedDate: Date = Date()
}
