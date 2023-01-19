//
//  Task.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

enum DifficultyLevel: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    case easy
    case medium
    case hard
}

enum Tag: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    case work
    case school
    case health
    case chores
}

//Adding Codable conformance for @Published properties
//https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties
class Task: Identifiable, ObservableObject, Codable {
    @Published var title: String
    @Published var difficulty: DifficultyLevel
    @Published var notes: String
    @Published var tags: [Tag] = [Tag]()
    @Published var isComplete: Bool = false
    
    enum CodingKeys: CodingKey {
        case title
        case difficulty
        case notes
        case tags
        case isComplete
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        notes = try container.decode(String.self, forKey: .notes)
        isComplete = try container.decode(Bool.self, forKey: .isComplete)
        difficulty = try container.decode(DifficultyLevel.self, forKey: .difficulty)
        tags = try container.decode([Tag].self, forKey: .tags)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(notes, forKey: .notes)
        try container.encode(isComplete, forKey: .isComplete)
        try container.encode(difficulty, forKey: .difficulty)
        try container.encode(tags, forKey: .tags)
    }
    
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag], isComplete: Bool) {
        self.title = title
        self.difficulty = difficulty
        self.notes = notes
        self.tags = tags
        self.isComplete = isComplete
    }
}

class Todo: Task{
    @Published var due_date: Date = Date.now + 7
    @Published var checkList: [Task] = [Task]()
    @Published var reminder: Date = Date.now
    
    enum CodingKeys: CodingKey {
        case due_date
        case checkList
        case reminder
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        due_date = try container.decode(Date.self, forKey: .due_date)
        checkList = try container.decode([Task].self, forKey: .checkList)
        reminder = try container.decode(Date.self, forKey: .reminder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(due_date, forKey: .due_date)
        try container.encode(checkList, forKey: .checkList)
        try container.encode(reminder, forKey: .reminder)
    }
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag], due_date: Date, checkList: [Task], reminder: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tags: tags,isComplete: false)
        self.due_date = due_date
        self.checkList = checkList
        self.reminder = reminder
    }
    
    static func getAnEmptyToDo() -> Todo {
        return Todo(title: "", difficulty: .easy, notes: "", tags: [Tag](), due_date: Date.now, checkList: [Task](), reminder: Date.now)
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
        dateFormatter.dateFormat = "MMM/dd/YYYY"

        // Convert Date to String
        return dateFormatter.string(from: due_date)
    }
}

class Dailies: Task {
    @Published var start_date: Date =  Date.now
    
    enum CodingKeys: CodingKey {
        case start_date
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        start_date = try container.decode(Date.self, forKey: .start_date)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(start_date, forKey: .start_date)
    }
    
    init(title: String, difficulty: DifficultyLevel, notes: String, tags: [Tag], isComplete: Bool, start_date: Date) {
        super.init(title: title, difficulty: difficulty, notes: notes, tags: tags, isComplete: isComplete)
        self.start_date = start_date
    }
    
    static func getAnEmptyDaily() -> Dailies {
        Dailies(title: "", difficulty: .easy, notes: "", tags: [Tag](), isComplete: false, start_date: Date.now)
    }
}


///
///Utitliy extensions
///
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
    
    func today() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM/dd/yyyy"
        return dateFormatter.string(from: Date.now)
    }
    
    
    //comes from
    //https://freakycoder.com/ios-notes-51-how-to-set-a-time-based-dynamic-greeting-message-swift-5-6c629632ceb5
    func greetings() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
      
      let NEW_DAY = 0
      let NOON = 12
      let SUNSET = 18
      let MIDNIGHT = 24
      
      var greetingText = "Hello" // Default greeting text
      switch hour {
      case NEW_DAY..<NOON:
          greetingText = "Good Morning"
      case NOON..<SUNSET:
          greetingText = "Good Afternoon"
      case SUNSET..<MIDNIGHT:
          greetingText = "Good Evening"
      default:
          _ = "Hello"
      }
      
      return greetingText
    }
}

///TODO
///1. dailies,   due_date ,  priority, sort by due date
