//
//  Concentration.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-24.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import Foundation

class Concentration
{
    
    var deck = [ Card ]()
    
    var singleFaceUpIndex : Int?

    init( pairCount : Int )
    {
        for i in 1 ... pairCount // loop identifier not used
        {
            let newCard = Card()
            deck.append( newCard )
            deck.append( newCard )
        }
    }
    
    func chooseCard( at chosenIndex: Int )
    {
        if !deck[ chosenIndex ].isMatched
        {
            if let matchIndex = singleFaceUpIndex, matchIndex != chosenIndex
            {
                // check whether cards match
                if deck[ matchIndex ].id == deck[ chosenIndex ].id
                {
                    deck[ matchIndex ].isMatched = true
                    deck[ chosenIndex ].isMatched = true
                }
                deck[ chosenIndex ].isFaceUp = true
                singleFaceUpIndex = nil
            }
            else
            {
                // no cards match or 2 cards face up
                for eachIndex in deck.indices
                {
                    deck[ eachIndex ].isFaceUp = false
                }
                deck[ chosenIndex ].isFaceUp = true
                singleFaceUpIndex = chosenIndex
            }
        }
    }
}
