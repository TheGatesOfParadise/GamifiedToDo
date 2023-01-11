//
//  User.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

//TODO: if User needs to be @State or @StateObject
//in order for User to be a @StateObject, it has to be an ObserverableObject
//which in turn requires User to be a class not a struct
struct User/*:ObservableObject */{
    var name: String
    var avatar: Avatar
    var award: Award
    var toDoList: [Todo]
    var DailiesList: [Dailies]
    
    init(name: String, avatar: Avatar, award: Award, toDoList: [Todo], DailiesList: [Dailies]) {
        self.name = name
        self.avatar = avatar
        self.award = award
        self.toDoList = toDoList
        self.DailiesList = DailiesList
    }
    
    
    
    static func getASampleUser() -> User {
        let currentDate = Date.now
        var dateComponent = DateComponents()
        dateComponent.day = 2
        let twoDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 6
        let sixDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 7
        let sevenDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateComponent.day = 10
        let tenDaysFromToday = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        return User(name: "Adams",
                    avatar: Avatar(parts: [AvatarPart(part: .head, category: .basic, index: 1),
                                           AvatarPart(part: .body, category: .basic, index: 1),
                                           AvatarPart(part: .bottom, category: .basic, index: 1)
                                          ]
                                  ),
                    award: Award(coin:2),
                    toDoList: [Todo(title: "Unit5 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tag: .school, 
                                    due_date: twoDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tag: .school,
                                                     isComplete: true),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tag: .school,
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit6 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tag: .school,
                                    due_date: sixDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tag: .school,
                                                     isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tag: .school,
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit7 MVP",
                                    difficulty: .hard,
                                    notes: "Voiceover",
                                    tag: .school,
                                    //due_date: Date.init("2023/02/20 14:50"),
                                    due_date: sevenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tag: .school,
                                                    isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tag: .school,
                                                    isComplete: false)
                                    ],
                                    reminder: Date.init("2023/02/12 14:50")),
                               Todo(title: "Unit8 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tag: .school,
                                    due_date: tenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tag: .school,
                                                    isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tag: .school,
                                                    isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),],
                    DailiesList: [Dailies(title: "Buy milk",
                                          difficulty: .easy,
                                          notes: "whole milk",
                                          tag: .chores, isComplete: false,
                                          start_date: Date.now),
                                  Dailies(title: "wash hair",
                                          difficulty: .medium,
                                          notes: "",
                                          tag: .chores, isComplete: false,
                                          start_date: Date.now),
                                  Dailies(title: "clean up room",
                                          difficulty: .hard,
                                          notes: "",
                                          tag: .chores, isComplete: false,
                                          start_date: Date.now)
                    ]
        )
    }
}
