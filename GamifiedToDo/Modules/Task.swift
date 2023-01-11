//
//  Task.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

enum DifficultyLevel: String {
    case easy
    case medium
    case hard
}

enum Tag: String {
    case work
    case school
    case health
    case chores
}

/*
enum ScheduleType: String {
    case due_date
    case start_date
}

struct Schedule {
    var type: ScheduleType
    var date: Date
}
*/

class Task: Identifiable {
    var title: String = ""
    var difficulty: DifficultyLevel = DifficultyLevel.easy
    var notes: String = ""
    var tag: Tag = Tag.school
    //var schedule: [Schedule] = []
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tag: Tag) {
        self.title = title
        self.difficulty = difficulty
        self.notes = notes
        self.tag = tag
    }
}

class Todo: Task {
    var due_date: Date = Date.now + 7
    var checkList: [Task] = []
    var reminder: Date = Date.now
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tag: Tag, due_date: Date, checkList: [Task], reminder: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tag: tag)
        self.due_date = due_date
        self.checkList = checkList
        self.reminder = reminder
    }
    
    func isWithinDays(interval: Int) -> Bool {
        if Date.now.interval(ofComponent: .day, fromDate: due_date) < interval {
            return true
        }
        else {
            return false
        }
    }
}

class Dailies: Task {
    var start_date: Date =  Date.now
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tag: Tag, start_date: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tag: tag)
        self.start_date = start_date
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

//https://stackoverflow.com/questions/40075850/swift-3-find-number-of-calendar-days-between-two-dates
extension Date {

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}

///TODO
///1. dailies,   due_date ,  priority
