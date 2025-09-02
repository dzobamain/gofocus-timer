//
//  DayPlan.swift
//  macos
//

import Foundation

struct DayPlan
{
    var description: String
    let date: Date
    
    var taskTimers: [TaskTimer]
    var reminders: [Reminder]
    var checkItems: [CheckItem]
    var quantityGoals: [QuantityGoal]
}

struct TaskTimer
{
    var description: String
    var duration: TimeInterval // sec
    var startTime: Date?
}

struct Reminder
{
    var description: String
    var time: Date
}

struct CheckItem
{
    var description: String
    var isCompleted: Bool
}

struct QuantityGoal
{
    var description: String
    var targetAmount: Double
    var currentAmount: Double
}
