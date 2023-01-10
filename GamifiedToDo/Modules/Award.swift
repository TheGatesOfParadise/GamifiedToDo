//
//  Award.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

struct Award {
    var coin: Int
    

}

struct TaskToAward {
    var award: Award
    var difficulty: DifficultyLevel
}

let taskToAwardRules: [TaskToAward] = [
    TaskToAward(award: Award(coin:1), difficulty: .easy),
    TaskToAward(award: Award(coin:3), difficulty: .medium),
    TaskToAward(award: Award(coin:5), difficulty: .hard)
]

enum AvatarPartType: String, CaseIterable {
    case head = "Head"
    case body = "Body"
    case bottom = "Bottom"
}

enum AvatarCategory: String, CaseIterable {
    case basic = "Basic"
    case animal = "Animal"
    case castle = "Castle"
}

struct AvatarPart {
    var part: AvatarPartType
    var category: AvatarCategory
    var index: Int
    
    var imageName: String {"\(part.rawValue.lowercased())_\(category.rawValue.lowercased())_\(index)"}
}

struct Avatar {
    var parts: [AvatarPart]
    
}

struct AwardToAvatarPart {
    var award: Award
    var part: AvatarPart
}


/*
= [
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .head, category: .basic, index: 1)),
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .head, category: .basic, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .body, category: .basic, index: 1)),
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .body, category: .basic, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .bottom, category: .basic, index: 1)),
    AwardToAvatarPart(award: Award(coin:1), part: AvatarPart(name: .bottom, category: .basic, index: 2)),
    
    
    AwardToAvatarPart(award: Award(coin:2), part: AvatarPart(name: .head, category: .animal, index: 1)),
    AwardToAvatarPart(award: Award(coin:2), part: AvatarPart(name: .head, category: .animal, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:2), part: AvatarPart(name: .body, category: .animal, index: 1)),
    AwardToAvatarPart(award: Award(coin:2), part: AvatarPart(name: .body, category: .animal, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .bottom, category: .animal, index: 1)),
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .bottom, category: .animal, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .head, category: .castle, index: 1)),
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .head, category: .castle, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .body, category: .castle, index: 1)),
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .body, category: .castle, index: 2)),
    
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .bottom, category: .castle, index: 1)),
    AwardToAvatarPart(award: Award(coin:3), part: AvatarPart(name: .bottom, category: .castle, index: 2)),
]

//
struct Model {
       let imageName: String
       let height: CGFloat
   }
   
    var models = [Model]()

       let images = Array(1...9).map { "image\($0)" }

/
models = images.compactMap {
           return  Model.init(
               imageName: $0,
               height: CGFloat.random(in: 200...400)
           )
       }
//
 */

var avatarCategories = [
    "Basic", "Animal", "Castle"
]

var partCategories = [
    "Head", "Body", "Bottom"
]
