//
//  Card.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-24.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import Foundation

struct Card : Hashable // conforms to Hashable protocol
{
    // hashValue and func == implement Hashable protocol
    var hashValue: Int { return id }
    
    static func ==( lhs : Card, rhs : Card ) -> Bool
    {
        return lhs.id == rhs.id
    }
    
    // accessible variables follow
    var isFaceUp         = false // when true, card is deemed face up, else face down
    var isMatched        = false // when true, card has been matched and has been removed from the game, else still in play

    private var id : Int // necessary for implementation but of no concern to the outside world
    
    init()
    {
        id = Card.generateId()
    }
    
    private static var idMaker = 0
    
    private static func generateId() -> Int
    {
        idMaker += 1
        return idMaker
    }
    
    // TODO: shuffle the cards
}
