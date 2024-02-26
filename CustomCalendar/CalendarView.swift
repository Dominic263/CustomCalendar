//
//  ContentView.swift
//  CustomCalendar
//
//  Created by DOMINIC NDONDO on 2/26/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @State private var date: Date = .now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
            //Calendar Header
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            
            //Calendar days
            LazyVGrid(columns: columns) {
                
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                Date.now.startOfDay == day.startOfDay ? .red.opacity(0.2) : color.opacity(0.2)
                                )
                            )
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
}

#Preview {
    CalendarView()
}
