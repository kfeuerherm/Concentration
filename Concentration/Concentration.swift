//
//  Concentration.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-24.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import Foundation

struct Concentration
{
    
    private( set ) var deck = [ Card ]() // have to provide access but modification must be restricted to this class
    
    private var singleFaceUpIndex : Int?
    {
        get
        {
            return deck.indices.filter { deck[ $0 ].isFaceUp }.single
        }
        set
        {
            for eachIndex in deck.indices
            {
                deck[ eachIndex ].isFaceUp = ( eachIndex == newValue )
            }
        }
    }

    init( pairCount : Int ) // inits must be accessible
    {
        assert( pairCount > 0, "Concentration.init( pairCount: \(pairCount) )-- must be positive" )

        for _ in 1 ... pairCount // loop identifier not used
        {
            let newCard = Card()
            deck.append( newCard )
            deck.append( newCard )
        }
    }
    
    mutating func chooseCard( at chosenIndex : Int ) // fundamental API
    {
        assert( deck.indices.contains( chosenIndex ), "Concentration.chooseCard( at : \(chosenIndex) )-- index not found" )
        
        // disregard a previously matched chosen card as there's nothing to do
        if !deck[ chosenIndex ].isMatched
        {
            // when only one card is face up and it's not this one, check for match
            if let matchIndex = singleFaceUpIndex, matchIndex != chosenIndex
            {
                // when ids match, we have a card match
                if deck[ matchIndex ] == deck[ chosenIndex ]
                {
                    deck[ matchIndex ].isMatched = true
                    deck[ chosenIndex ].isMatched = true
                }
                // either way, this card is now face up
                deck[ chosenIndex ].isFaceUp = true
            }
            // 0 or 2 cards face up, or no match
            else
            {
                // set the choseen card to be the only face up card
                // (which implicitly turns all other cards down as it's a computed property)
                singleFaceUpIndex = chosenIndex
            }
        }
    }
}
