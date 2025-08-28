//
//  GoFocus/ContentView.swift
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0)
            {
                VStack {
                    Text("Hello, world!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.09))
                }

                ScrollView
                {
                    VStack(spacing: 20)
                    {
                        ForEach(0..<12)
                        {
                            offset in CalendarMonthView(monthOffset: offset, selectedDate: $selectedDate)
                            {
                                tappedDate in handleDateTap(tappedDate)
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: WINDOW_MIN_WIDTH / 2, height: geometry.size.height)
                .background(Color(NSColor.windowBackgroundColor))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .frame(minWidth: WINDOW_MIN_WIDTH, minHeight: WINDOW_MIN_HEIGHT)
    }

    private func handleDateTap(_ date: Date)
    {
        print("Cliced on:", date)
    }
}

// Show one month
struct CalendarMonthView: View
{
    let monthOffset: Int
    @Binding var selectedDate: Date
    var onDayTap: (Date) -> Void

    private var monthDate: Date
    {
        Calendar.current.date(byAdding: .month, value: monthOffset, to: Date()) ?? Date()
    }
    
    private var monthName: String
    {
        let formatter = DateFormatter()
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
                    let weekday = Calendar.current.component(.weekday, from: day)
                    let isWeekend = (weekday == 1 || weekday == 7) // Sunday or Saturday
                    let inCurrentMonth = Calendar.current.isDate(day, equalTo: monthDate, toGranularity: .month)

                    Text("\(Calendar.current.component(.day, from: day))")
                        .foregroundColor(inCurrentMonth ? (isWeekend ? .red.opacity(1.2) : .primary) : Color.gray.opacity(0.2))
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .background(
                            Calendar.current.isDate(day, inSameDayAs: selectedDate)
                            ? Color.accentColor.opacity(0.3)
                            : Color.clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .onTapGesture {
                            selectedDate = day
                            onDayTap(day)
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
        guard let monthInterval = calendar.dateInterval(of: .month, for: month), let firstWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.start))
        else
        {
            return []
        }

        var days: [Date] = []
        var current = firstWeekStart
        
        while current <= monthInterval.end
        {
            days.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return days
    }
}

#Preview {
    ContentView()
}
