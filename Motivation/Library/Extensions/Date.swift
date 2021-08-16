//
//  Date.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation


extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return gregorianCalendar.date(from: dateComponents)!
    }
    
    
    static var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }
    
    
    func truncateTime() -> Date {
        let useComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        var components = Date.calendar.dateComponents(useComponents, from: self)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Date.calendar.date(from: components)!
    }
    
    
    func add(days: Int) -> Date {
        return Date.calendar.date(byAdding: .day, value: days, to: self)!
        
//        var dateComponents = DateComponents()
//        dateComponents.day = days
//        return Date.calendar.date(byAdding: dateComponents, to: self)!
    }
    
    
    func add(months: Int) -> Date {
        return Date.calendar.date(byAdding: .month, value: months, to: self)!
    }
    
    
    var weekday: Int { // 0 - Monday
        return (Date.calendar.dateComponents([.weekday], from: self).weekday! + 5) % 7
    }
    

    #if !os(watchOS)
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    
    var yearName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    
    var weekdayName: String { return WeekdayNames[weekday] }
    var shortWeekdayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EE"
        return String(dateFormatter.string(from: self).prefix(2))
    }
    
    
    var shortDateName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd MMM"
        return dateFormatter.string(from: self)
    }
    #endif

    
    
    func daysTo(date: Date) -> Int {
        let components = Date.calendar.dateComponents([.day], from: self, to: date)
        return components.day!
    }
    
    
    var startOfMonth: Date {
        let interval = Date.calendar.dateInterval(of: .month, for: self)
        return interval?.start ?? self
    }
    
    
    var startOfWeek: Date {
        let date = Date.calendar.date(from: Date.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    
    var startOfDay: Date {
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = Date.calendar.dateComponents(unitFlags, from: self)
        return Date.calendar.date(from: components)!
    }
    
    
    var endOfDay: Date {
        return startOfDay.nextDay.addingTimeInterval(-1)
    }
    
    
    var endOfWeek: Date {
        return startOfWeek.add(days: 7).addingTimeInterval(-1)
    }
    
    
    var endOfMonth: Date {
        let interval = Date.calendar.dateInterval(of: .month, for: self)
        return interval?.end ?? self
    }
    
    
    var nextDay: Date {
        return self.startOfDay.add(days: 1)
    }
    
    
    func isInSameWeek(date: Date?) -> Bool {
        guard let date = date else { return false }
        return Date.calendar.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    
    
    func isInSameMonth(date: Date?) -> Bool {
        guard let date = date else { return false }
        return Date.calendar.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    
    func isInSameYear(date: Date?) -> Bool {
        guard let date = date else { return false }
        return Date.calendar.isDate(self, equalTo: date, toGranularity: .year)
    }
    
    
    func isInSameDay(date: Date?) -> Bool {
        guard let date = date else { return false }
        return Date.calendar.isDate(self, equalTo: date, toGranularity: .day)
    }
    
    
    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }
    
    
    var isInThisMonth: Bool {
        return isInSameMonth(date: Date())
    }
    
    
    var isInToday: Bool {
        return Date.calendar.isDateInToday(self)
    }
    
    
    var day: Int { return Date.calendar.component(.day, from: self) }
    
    
    var thisWeekMonday: Date { return startOfWeek }
    var thisWeekTuesday: Date { return startOfWeek.add(days: 1) }
    var thisWeekWednesday: Date { return startOfWeek.add(days: 2) }
    var thisWeekThursday: Date { return startOfWeek.add(days: 3) }
    var thisWeekFriday: Date { return startOfWeek.add(days: 4) }
    var thisWeekSaturday: Date { return startOfWeek.add(days: 5) }
    var thisWeekSunday: Date { return startOfWeek.add(days: 6) }
    
    
    var nsDate: NSDate { return self as NSDate }
    
    #if !os(watchOS)
    var iso8601: String { return Formatter.iso8601.string(from: self) }
    #endif
    
    static var is24Hours: Bool {
        let formatString = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)!
        return !formatString.contains("a")
    }
    
    
    func round(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .toNearestOrAwayFromZero)
    }
    
    
    func ceil(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .up)
    }
    
    
    func floor(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .down)
    }
    
    
    func round(precision: TimeInterval, rule: FloatingPointRoundingRule) -> Date {
        let seconds = (self.timeIntervalSinceReferenceDate / precision).rounded(rule) * precision
        return Date(timeIntervalSinceReferenceDate: seconds)
    }
}


extension Date {
    func dateComponents(components: Set<Calendar.Component> = [.day, .month, .year]) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(components, from: self)
    }

    func dateString(withFormat format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

