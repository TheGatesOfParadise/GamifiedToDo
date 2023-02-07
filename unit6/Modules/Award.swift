//
//  Award.swift
//  unit6
//
<<<<<<< Updated upstream
//  Created by Scarlett Ruan on 2/3/23.
=======
<<<<<<< HEAD
//  Created by Scarlett Ruan on 2/6/23.
=======
//  Created by Scarlett Ruan on 2/3/23.
>>>>>>> f88bdbe13447966002363038853cb2fb99dcc7e7
>>>>>>> Stashed changes
//

import Foundation

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
///Represents Award
///Right now Award is represented by property coin, more coins means more award.
///
struct Award: Codable {
    var coin: Int
    
    init(coin: Int) {
        self.coin = coin
    }
    
    mutating func add(award: Award) {
        self.coin += award.coin
    }
    
    mutating func minus(award: Award) {
        self.coin -= award.coin
    }
}

///Cat is comprised of an array of CatPart.
struct Cat: Codable {
    var parts: CatPart
    
    ///convenient function to get a sample Cat object
    static func getSampleCat() -> Cat {
        return Cat(parts: CatPart(type: .figure, index: 3)
        )
    }
}

///property `imageName` - respresents the image in Assets
struct CatPart: Hashable, Codable {
    var type: CatType
    var index: Int
    var imageName: String {"\(type.rawValue.lowercased())_\(index)"}
}

enum CatType: String, CaseIterable, Codable {
    case head = "Head"
    case figure = "Figure"
}


=======
>>>>>>> f88bdbe13447966002363038853cb2fb99dcc7e7
>>>>>>> Stashed changes


