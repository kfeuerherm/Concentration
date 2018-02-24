//
//  Card.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-24.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import Foundation

struct Card
{
    
    var id        : Int
    var isFaceUp        = false
    var isMatched       = false
    
    init()
    {
        self.id = Card.generateId() // 'self' means 'belonging to the class'
    }
    
    static var idMaker = 0
    
    static func generateId() -> Int
    {
        idMaker += 1
        return idMaker
    }
    
    // TODO: shuffle the cards
}
