//
//  Rules.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/10/23.
//

import Foundation

struct Rules {
    static var awardToAvatarPartRules = [AwardToAvatarPart]()
    static let indexes = Array(1...12).map { $0 }
    
    static func initRules() {
        AvatarCategory.allCases.forEach {
            let categoryName = $0
            AvatarPartType.allCases.forEach {
                let partName = $0
                awardToAvatarPartRules += indexes.compactMap {
                    return AwardToAvatarPart(award: Award(coin:categoryName == .basic ? 1: categoryName == .animal ? 2 : 3),
                                             part: AvatarPart(part: partName, category: categoryName, index: $0))
                }
            }
        }
        
        awardToAvatarPartRules.forEach{
            $0.printRule()
        }
        
    }
}
