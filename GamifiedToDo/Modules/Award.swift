//
//  Award.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/9/23.
//

import Foundation

struct Award: Codable {
    var coin: Int
}

struct TaskToAward {
    var award: Award
    var difficulty: DifficultyLevel
}


enum AvatarPartType: String, CaseIterable, Codable {
    case head = "Head"
    case body = "Body"
    case bottom = "Bottom"
}

enum AvatarCategory: String, CaseIterable, Codable {
    case basic = "Basic"
    case animal = "Animal"
    case castle = "Castle"
}

struct AvatarPart: Hashable, Codable {
    var part: AvatarPartType
    var category: AvatarCategory
    var index: Int
    
    var imageName: String {"\(part.rawValue.lowercased())_\(category.rawValue.lowercased())_\(index)"}
}

struct Avatar: Codable {
    var parts: [AvatarPart]
    
}

struct AwardToAvatarPart {
    var award: Award
    var part: AvatarPart
    
    func printRule() {
        print("Award:\(award.coin) to \(part.imageName)")
    }
}

var avatarCategories = [
    "Basic", "Animal", "Castle"
]

var partCategories = [
    "Head", "Body", "Bottom"
]
