//
//  Rules.swift
//  unit6
//
//  Created by Scarlett Ruan on 2/6/23.
//

import Foundation
import SwiftUI


let basicLevelCoins = 5
let silverLevelCoins = 75
let goldLevelCoins = 150
let platinumLevelCoins = 300
let indexes = Array(1...12).map { $0 }

struct Rules {
    private var awardToCatPartRules = [CatPart: Award]()
    private var taskToAwardRules = [DifficultyLevel: Award]()
    
    init() {
        //all basic cat part needs basicLevelCoins
        indexes.forEach {num in
            CatType.allCases.forEach {
                let partName = $0
                if num < 3 {
                    awardToCatPartRules[CatPart(type: partName, index: num)] = Award(coin:basicLevelCoins)
                } else if  num < 7 {
                    awardToCatPartRules[CatPart(type: partName, index: num)] = Award(coin:silverLevelCoins)
                } else if  num < 10 {
                    awardToCatPartRules[CatPart(type: partName, index: num)] = Award(coin:goldLevelCoins)
                }   else if num < 13{
                    awardToCatPartRules[CatPart(type: partName, index: num)] = Award(coin:platinumLevelCoins)
                }
            }
            
            
            //fill in taskToAwardRules
            taskToAwardRules[.easy] = Award(coin:15)
            taskToAwardRules[.medium] = Award(coin:30)
            taskToAwardRules[.hard] = Award(coin:45)
        }
    }
        
        
        func printRules() -> Void {
            
            print("taskToAwardRules")
            for (key,value) in taskToAwardRules {
                print("\(key) = \(value)")
            }
            
            print("awardToAvatarPartRules")
            for (key,value) in awardToCatPartRules {
                print("\(key) = \(value)")
            }
        }
        
        ///This function tells how much award is earned based on difficulty level of a todo
        ///In Parameter --`taskLevel`: DifficultyLevel can be easy, medium and hard
        ///Return --`Award`: the award earned based on preset rules from the todo
        ///
        func getAward(taskLevel: DifficultyLevel) -> Award {
            guard let _ = taskToAwardRules[taskLevel] else {
                return Award(coin:20)
            }
            
            return taskToAwardRules[taskLevel]!
        }
        
        
        ///This function tells how much award is needed  to purchase a cat
        ///In Parameter --`avatarPart`: the cat part to be purchased
        ///Return --`Award`: the award needed for the cat
        ///
        func getAward(catPart: CatPart) -> Award {
            guard let _ = awardToCatPartRules[catPart] else {
                return Award(coin:40)
            }
            
            return awardToCatPartRules[catPart]!
        }
}

