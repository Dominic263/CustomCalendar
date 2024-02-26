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
    let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]
    
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
        }
        .padding()
    }
}

#Preview {
    CalendarView()
}
