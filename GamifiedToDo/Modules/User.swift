//
//  User.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

class UserModel:ObservableObject {
    @Published var user: User
    var rules: Rules
    var userDailiesCompletionStatus: CGFloat {
        //get total dailiy list
        var total: Int = 0
        var completed: Int = 0
        user.dailiesList.forEach{ daily in
            total += Rules.taskToAwardRules[daily.difficulty]!.coin
            
            if daily.isComplete {
                completed += Rules.taskToAwardRules[daily.difficulty]!.coin
            }
        }
        
        if total == 0 {
            return 0.0
        }
        else {
            return Double(completed) / Double(total)
        }
    }
    
    var userTotalCoin: Int {
        var result: Int = 0
        
        //total conins earned from ToDoList
        user.toDoList.forEach { toDo in
            if toDo.isComplete {
                result += Rules.taskToAwardRules[toDo.difficulty]!.coin
            }
            else {
                toDo.checkList.forEach{ checkItem in
                    if checkItem.isComplete {
                        result += Rules.taskToAwardRules[checkItem.difficulty]!.coin
                    }
                }
            }
        }
        
        //total coins earned from Dailies
        user.dailiesList.forEach{ daily in
            if daily.isComplete {
                result += Rules.taskToAwardRules[daily.difficulty]!.coin
            }
        }
        
        return result
    }

    init(user:User, rules: Rules){
        self.user = user
        self.rules = rules
    }
    
    //force a view to update comes from this post:
    //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
    func updateView(){
        self.objectWillChange.send()
    }
    
}

class User :ObservableObject  {
    @Published var name: String
    @Published var avatar: Avatar
    @Published var award: Award
    @Published var toDoList: [Todo]
    @Published var dailiesList: [Dailies]
    
    init(name: String, avatar: Avatar, award: Award, toDoList: [Todo], dailiesList: [Dailies]) {
        self.name = name
        self.avatar = avatar
        self.award = award
        self.toDoList = toDoList
        self.dailiesList = dailiesList
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
                                    tags: [.school,.chores],
                                    due_date: twoDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school],
                                                     isComplete: true),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school],
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit6 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: [.school],
                                    due_date: sixDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.health],
                                                     isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health] ,
                                                     isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit7 MVP",
                                    difficulty: .hard,
                                    notes: "Voiceover",
                                    tags: [.school, .chores],
                                    //due_date: Date.init("2023/02/20 14:50"),
                                    due_date: sevenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school],
                                                    isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health],
                                                    isComplete: false)
                                    ],
                                    reminder: Date.init("2023/02/12 14:50")),
                               Todo(title: "Unit8 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: nil,
                                    due_date: tenDaysFromToday!,
                                    checkList: [Task(title: "Step1",
                                                     difficulty: .medium,
                                                     notes: "finish step1å",
                                                     tags: [.school, .health],
                                                    isComplete: false),
                                                Task(title: "Step2",
                                                     difficulty: .medium,
                                                     notes: "finish step2",
                                                     tags: [.school, .health],
                                                    isComplete: false)
                                    ],
                                    reminder: Date.init("2023/01/26 13:35")),
                               Todo(title: "Unit9 MVP",
                                    difficulty: .hard,
                                    notes: "gamified todos",
                                    tags: nil,
                                    due_date: tenDaysFromToday!,
                                    checkList: [],
                                    reminder: Date.init("2023/01/26 13:35"))],
                    dailiesList: [Dailies(title: "Buy milk",
                                          difficulty: .easy,
                                          notes: "whole milk",
                                          tags: [.chores],
                                          isComplete: true,
                                          start_date: Date.now),
                                  Dailies(title: "wash hair",
                                          difficulty: .medium,
                                          notes: "",
                                          tags: [.chores],
                                          isComplete: true,
                                          start_date: Date.now),
                                  Dailies(title: "clean up room",
                                          difficulty: .hard,
                                          notes: "",
                                          tags: [.chores],
                                          isComplete: false,
                                          start_date: Date.now)
                    ]
        )
    }
}
