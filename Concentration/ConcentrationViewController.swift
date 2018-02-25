//
//  ViewController.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-23.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import UIKit

class ConcentrationViewController : UIViewController
{
    
    // lazy: defer initialization until first access; this allows us to
    //       treat 'game' as initialized even though it references another
    //       class variable before all initializations are complete
    // + 1:  ensure the game will work in the unlikely event that there is
    //       an odd number of buttons (though in fact the odd card will not
    //       be matchable)
    
    private( set ) var flipCount = 0 // outside access permitted, but must protect against alteration
    {
        didSet
        {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var flipCountLabel : UILabel!
    {
        didSet
        {
            updateFlipCountLabel()
        }
    }

    private func updateFlipCountLabel()
    {
        let attributes : [ NSAttributedStringKey : Any ] = [ .strokeWidth : 5.0, .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) ]
        let attributedString = NSAttributedString( string : "\(flipCount)", attributes : attributes )
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons : [ UIButton ]!
    
    var pairCount : Int // allow outsiders to read this, no need for secrecy
    {
        assert(cardButtons.count % 2 == 0, "Button count is \(cardButtons.count)--- should be even" )
        
        return cardButtons.count / 2
    }
    
    private lazy var game = Concentration( pairCount : pairCount ) // private since outsiders cannot determine button/pair count
    
    @IBAction private func touchCard( _ sender : UIButton )
    {
        if let cardIndex = cardButtons.index( of : sender )
        {
            game.chooseCard( at: cardIndex )
            refreshView()
            if !game.deck[ cardIndex ].isMatched
            {
                flipCount += 1
            }
        }
        else
        {
            // covers the eventuality that a button wasn't linked up
        }
    }
    
    private func refreshView()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[ index ]
            let card = game.deck[ index ]
            if card.isFaceUp
            {
                button.setTitle( toEmoji( for: card ), for : UIControlState.normal )
                button.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else
            {
                button.setTitle( "", for : UIControlState.normal )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices     = "😈👹👺💩👻💀☠️👽👾🤖🎃😺🐴🦄🐝🐛🦋🐌🐞🦀"
    
    private var emojiUsed        = [ Card : String ]()
    
    private func toEmoji( for card : Card ) -> String
    {
        if emojiUsed[ card ] == nil, emojiChoices.count > 0
        {
            let randomStringIndex = emojiChoices.index( emojiChoices.startIndex, offsetBy : emojiChoices.count.arc4random )
            emojiUsed[ card ] = String( emojiChoices.remove( at : randomStringIndex ) )
        }
        return emojiUsed[ card ] ?? "?"
    }
}
