//
//  Date+Extensions.swift
//  CustomCalendar
//
//  Created by DOMINIC NDONDO on 2/26/24.
//

import Foundation


extension Date {
    
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols

        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }
    
    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    //returns the start day for evry month
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    //returns the end day of every month
    // .end returns one day above the last day so we need to subtract one to get the true last date
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    //returns the start day of the previous month
    var startOfPreviousMonth: Date {
        let dayInpreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInpreviousMonth.startOfMonth
    }
    
    //number of days in a month
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    //sunday before start of month
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    //Returns the proper days to be displayed by the calendar view based
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        //Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)!
            days.append(newDay)
        }
        
        //Previous Month Days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)!
            days.append(newDay)
        }
        
        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth }.sorted(by: < )
        
    }
    
    //returns the month number of that specific date
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
