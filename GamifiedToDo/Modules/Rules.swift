
import Foundation
import SwiftUI

let lowLevlCoins = 5
let basicLevelCoins = 30
let silverLevelCoins = 100
let goldLevelCoins = 200
let plantinumLevelCoins = 500
let extremelyHighLevelCoins = 10000

let indexes = Array(1...12).map { $0 }

struct Rules {
    private var awardToAvatarPartRules = [AvatarPart: Award]()
    
    private var taskToAwardRules = [DifficultyLevel: Award]()
    
    init() {
        //all basic avatar part needs basicLevelCoins
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                if num < 7 {
                    awardToAvatarPartRules[AvatarPart(part: partName, category: .basic, index: num)] = Award(coin:lowLevlCoins)
                }else {
                    awardToAvatarPartRules[AvatarPart(part: partName, category: .basic, index: num)] = Award(coin:basicLevelCoins)
                }
            }
        }
        
        //all animal avatar part needs silverLevelCoins
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                awardToAvatarPartRules[AvatarPart(part: partName, category: .animal, index: num)] = Award(coin:silverLevelCoins)
            }
        }
        
        //castle avatar part needs silverLevelCoins (1..6) or plantinumLevelCoins (7..12)
        indexes.forEach {num in
            AvatarPartType.allCases.forEach {
                let partName = $0
                if num < 7 {
                    awardToAvatarPartRules[AvatarPart(part: partName, category: .castle, index: num)] = Award(coin:goldLevelCoins)
                }
                else {
                    awardToAvatarPartRules[AvatarPart(part: partName, category: .castle, index: num)] = Award(coin:plantinumLevelCoins)
                }
            }
        }
        
        //fill in taskToAwardRules
        taskToAwardRules[.easy] = Award(coin:1)
        taskToAwardRules[.medium] = Award(coin:3)
        taskToAwardRules[.hard] = Award(coin:5)
    }
    
    
    func printRules() -> Void {
        
        print("taskToAwardRules")
        for (key,value) in taskToAwardRules {
            print("\(key) = \(value)")
        }
        
        print("awardToAvatarPartRules")
        for (key,value) in awardToAvatarPartRules {
            print("\(key) = \(value)")
        }
    }
    
    func getAward(taskLevel: DifficultyLevel) -> Award {
        guard let _ = taskToAwardRules[taskLevel] else {
            return Award(coin:extremelyHighLevelCoins)
        }
        
        return taskToAwardRules[taskLevel]!
    }
    
    func getAward(avatarPart: AvatarPart) -> Award {
        guard let _ = awardToAvatarPartRules[avatarPart] else {
            return Award(coin:extremelyHighLevelCoins)
        }
        
        return awardToAvatarPartRules[avatarPart]!
    }
}
