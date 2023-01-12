//
//  Task.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

enum DifficultyLevel: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case easy
    case medium
    case hard
}

enum Tag: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case work
    case school
    case health
    case chores
}

class Task: Identifiable {
    var title: String
    var difficulty: DifficultyLevel
    var notes: String
    var tags: [Tag]?
    var isComplete: Bool = false
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag]?, isComplete: Bool) {
        self.title = title
        self.difficulty = difficulty
        self.notes = notes
        self.tags = tags
        self.isComplete = isComplete
    }
}

class Todo: Task {
    var due_date: Date = Date.now + 7
    var checkList: [Task] = []
    var reminder: Date = Date.now
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag]?, due_date: Date, checkList: [Task], reminder: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tags: tags,isComplete: false)
        self.due_date = due_date
        self.checkList = checkList
        self.reminder = reminder
    }
    
    override var isComplete: Bool {
        get {
            var result = true
            for task in checkList {
                result = result && task.isComplete
            }
            
            return result
        }
        set {
            self.isComplete = newValue
        }
    }
    
    var numberOfCheckList: Int {
        return checkList.count
    }
    
    func numberofCompletedCheckList() -> Int {
        var count = 0
        for task in checkList {
            if task.isComplete {
                count += 1
            }
        }
        return count
    }
    
    func isWithinDays(interval: Int) -> Bool {
        if Date.now.interval(ofComponent: .day, fromDate: due_date) < interval {
            return true
        }
        else {
            return false
        }
    }
    
    func dueDateString () -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/YY"

        // Convert Date to String
        return dateFormatter.string(from: due_date)
    }
    
    
}

class Dailies: Task {
    var start_date: Date =  Date.now
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag], isComplete: Bool, start_date: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tags: tags, isComplete: isComplete)
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
