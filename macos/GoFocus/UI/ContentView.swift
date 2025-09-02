//
//  GoFocus/UI/ContentView.swift
//

import SwiftUI

struct Note: Identifiable
{
    let id = UUID()
    let title: String
    let date: Date
}

struct ContentView: View
{
    @StateObject private var calendarState = CalendarState()

    private let notes: [Note] =
    [
        Note(title: "Test", date: Date()),
        Note(title: "Test1", date: Date().addingTimeInterval(86400)),
    ]

    var body: some View
    {
        GeometryReader
        {
            geometry in

            HStack(spacing: 0)
            {
                ScrollView
                {
                    VStack(alignment: .leading, spacing: 12)
                    {
                        ForEach(filteredNotes)
                        {
                            note in

                            VStack(alignment: .leading, spacing: 4)
                            {
                                Text(note.title)
                                    .font(.headline)

                                Text(note.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.09))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .background(Color(NSColor.windowBackgroundColor))

                ScrollView
                {
                    VStack(spacing: 20)
                    {
                        ForEach(0..<12)
                        {
                            offset in

                            CalendarMonthView(
                                monthOffset: offset,
                                calendarState: calendarState,
                                onDayTap: handleDateTap
                            )
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
        .onAppear
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone.current
            
            print("Clicked on:", formatter.string(from: calendarState.selectedDate))
        }
    }

    private var filteredNotes: [Note]
    {
        notes.filter
        {
            Calendar.current.isDate($0.date, inSameDayAs: calendarState.selectedDate)
        }
    }

    private func handleDateTap()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current

        print("Clicked on:", formatter.string(from: calendarState.selectedDate))
    }
}

#Preview
{
    ContentView()
}
