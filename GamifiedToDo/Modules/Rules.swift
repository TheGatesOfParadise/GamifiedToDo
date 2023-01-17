//
//  Rules.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/10/23.
//

import Foundation

struct Rules {
    static var awardToAvatarPartRules : [AwardToAvatarPart] {
        var localRules = [AwardToAvatarPart]()
        AvatarCategory.allCases.forEach {
            let categoryName = $0
            AvatarPartType.allCases.forEach {
                let partName = $0
                localRules += indexes.compactMap {
                    return AwardToAvatarPart(award: Award(coin:categoryName == .basic ? 1: categoryName == .animal ? 2 : 3),
                                             part: AvatarPart(part: partName, category: categoryName, index: $0))
                }
            }
        }
       
        localRules.forEach{
            $0.printRule()
        }
    
        return localRules
    }
    
    static private let indexes = Array(1...12).map { $0 }
    static let taskToAwardRules: [DifficultyLevel: Award] = [ .easy : Award(coin:1),
                                                              .medium : Award(coin:3),
                                                              .hard : Award(coin:5)]
    
    static func initRules() -> [AwardToAvatarPart] {
        var localRules = [AwardToAvatarPart]()
        AvatarCategory.allCases.forEach {
            let categoryName = $0
            AvatarPartType.allCases.forEach {
                let partName = $0
                localRules += indexes.compactMap {
                    return AwardToAvatarPart(award: Award(coin:categoryName == .basic ? 1: categoryName == .animal ? 2 : 3),
                                             part: AvatarPart(part: partName, category: categoryName, index: $0))
                }
            }
        }
        
        awardToAvatarPartRules.forEach{
            $0.printRule()
        }
        
        return localRules
    }
    
}
