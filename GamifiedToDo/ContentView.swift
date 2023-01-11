//
//  ContentView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct ContentView: View {
 /*   @State var user: User
    
    init() {
        Rules.initRules()
        
        
        user = User(name: "Adams",
                        avatar: Avatar(parts: [AvatarPart(part: .head, category: .basic, index: 1),
                                               AvatarPart(part: .body, category: .basic, index: 1),
                                               AvatarPart(part: .bottom, category: .basic, index: 1)
                                              ]
                                      ),
                        award: Award(coin:2),
                        toDoList: [Todo(title: "Unit6 MVP",
                                        difficulty: .hard,
                                        notes: "gamified todos",
                                        tag: .school,
                                        due_date: Date.init("2023/02/03 13:35"),
                                        checkList: [Task(title: "Step1",
                                                         difficulty: .medium,
                                                         notes: "finish step1å",
                                                         tag: .school),
                                                    Task(title: "Step2",
                                                                     difficulty: .medium,
                                                                     notes: "finish step2",
                                                                     tag: .school)
                                        ],
                                        reminder: Date.init("2023/01/26 13:35"))],
                        DailiesList: [Dailies(title: "Buy milk",
                                              difficulty: .easy,
                                              notes: "whole milk",
                                              tag: .chores,
                                              start_date: Date.now),
                                      Dailies(title: "wash hair",
                                              difficulty: .easy,
                                              notes: "",
                                              tag: .chores,
                                              start_date: Date.now)
                        ]
        )
    }
    */
    
    var body: some View {
        Overview()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
