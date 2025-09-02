//
//  GoFocus/UI/CalendarMonthView.swift
//

import SwiftUI

struct CalendarMonthView: View
{
    let monthOffset: Int
    @ObservedObject var calendarState: CalendarState
    var onDayTap: () -> Void

    private var monthDate: Date
    {
        Calendar.current.date(byAdding: .month, value: monthOffset, to: Date()) ?? Date()
    }

    private var monthName: String
    {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "LLLL yyyy"

        return formatter.string(from: monthDate)
    }

    var body: some View
    {
        VStack(alignment: .center, spacing: 5)
        {
            Text(monthName.capitalized)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 5)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7))
            {
                ForEach(daysForCalendar(month: monthDate), id: \.self)
                {
                    day in

                    let dayNumber = Calendar.current.component(.day, from: day)
                    let weekday = Calendar.current.component(.weekday, from: day)
                    let isWeekend = (weekday == 1 || weekday == 7)
                    let inCurrentMonth = Calendar.current.isDate(day, equalTo: monthDate, toGranularity: .month)
                    let isSelected = Calendar.current.isDate(day, inSameDayAs: calendarState.selectedDate)

                    let foregroundColor: Color = inCurrentMonth
                        ? (isWeekend ? .red : .primary)
                        : Color.gray.opacity(0.2)

                    let backgroundColor: Color = isSelected
                        ? Color.accentColor.opacity(0.3)
                        : Color.clear

                    Text("\(dayNumber)")
                        .foregroundColor(foregroundColor)
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .background(backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .onTapGesture
                        {
                            calendarState.selectedDate = day
                            onDayTap()
                        }
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.09))
        .cornerRadius(10)
    }

    private func daysForCalendar(month: Date) -> [Date]
    {
        let calendar = Calendar.current

        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
              let firstWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.start))
        else
        {
            return []
        }

        var days: [Date] = []
        var current = firstWeekStart
        let lastDayOfMonth = calendar.date(byAdding: .day, value: -1, to: monthInterval.end)!
        let isLastDaySunday = calendar.component(.weekday, from: lastDayOfMonth) == 1

        let lastWeekEnd: Date
        if isLastDaySunday
        {
            lastWeekEnd = lastDayOfMonth
        }
        else
        {
            let lastWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.end))!
            lastWeekEnd = calendar.date(byAdding: .day, value: 6, to: lastWeekStart)!
        }

        while current <= lastWeekEnd
        {
            var components = calendar.dateComponents([.year, .month, .day], from: current)
            components.hour = 12

            if let safeDate = calendar.date(from: components)
            {
                days.append(safeDate)
            }

            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }

        return days
    }
}
