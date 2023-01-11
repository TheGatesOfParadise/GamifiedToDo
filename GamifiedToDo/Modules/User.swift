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
}
