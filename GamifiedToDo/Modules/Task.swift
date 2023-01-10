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

class Task {
    var title: String = ""
    var difficulty: DifficultyLevel = DifficultyLevel.easy
    var notes: String = ""
    var tag: Tag = Tag.school
    //var schedule: [Schedule] = []
}

class Todo: Task {
    var due_date: Date = Date.now
    var checkList: [Task] = []
    var reminder: Date = Date.now
}

class Dailies: Task {
    var start_date: Date =  Date.now
}
