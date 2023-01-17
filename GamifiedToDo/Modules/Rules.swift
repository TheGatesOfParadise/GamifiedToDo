
import Foundation
import SwiftUI

let basicLevelCoins = 30
let silverLevelCoins = 100
let goldLevelCoins = 200
let plantinumLevelCoins = 500

let indexes = Array(1...12).map { $0 }

struct Rules {
    static var awardToAvatarPartRules = [AvatarPart: Award]()

    static var taskToAwardRules = [DifficultyLevel: Award]()
    
    init() {
        //all basic avatar part needs basicLevelCoins
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                Rules.awardToAvatarPartRules[AvatarPart(part: partName, category: .basic, index: num)] = Award(coin:basicLevelCoins)
            }
        }
        
        //all animal avatar part needs silverLevelCoins
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                Rules.awardToAvatarPartRules[AvatarPart(part: partName, category: .animal, index: num)] = Award(coin:silverLevelCoins)
            }
        }
        
        //castle avatar part needs silverLevelCoins (1..6) or plantinumLevelCoins (7..12)
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                if num < 7 {
                    Rules.awardToAvatarPartRules[AvatarPart(part: partName, category: .castle, index: num)] = Award(coin:goldLevelCoins)
                }
                else {
                    Rules.awardToAvatarPartRules[AvatarPart(part: partName, category: .castle, index: num)] = Award(coin:plantinumLevelCoins)
                }
            }
        }
        
        //fill in taskToAwardRules
        Rules.taskToAwardRules[.easy] = Award(coin:1)
        Rules.taskToAwardRules[.medium] = Award(coin:3)
        Rules.taskToAwardRules[.hard] = Award(coin:5)
    }
    
    static func printRules() -> Void {
        
        print("taskToAwardRules")
        for (key,value) in Rules.taskToAwardRules {
            print("\(key) = \(value)")
        }
        
        print("awardToAvatarPartRules")
        for (key,value) in Rules.awardToAvatarPartRules {
            print("\(key) = \(value)")
        }
        

    }
    
}
