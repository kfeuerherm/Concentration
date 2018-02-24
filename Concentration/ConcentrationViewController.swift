//
//  ViewController.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-23.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController
{
    
    // lazy: defer initialization until first access; this allows us to
    //       treat 'game' as initialized even though it references another
    //       class variable before all initializations are complete
    // + 1:  ensure the game will work in the unlikely event that there is
    //       an odd number of buttons (though in fact the odd card will not
    //       be matchable)
    lazy var game         = Concentration( pairCount : ( cardButtons.count + 1 ) / 2 )
    var emojiChoices = [ "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️" ]
    var emojiDict = [ Int : String ]()
    
    var flipCount    = 0 { didSet { flipCountLabel.text = "\(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel : UILabel!
    
    @IBOutlet var cardButtons : [ UIButton ]!
    
    @IBAction func touchCard( _ sender : UIButton )
    {
        
        if let cardIndex = cardButtons.index( of : sender )
        {
            game.chooseCard( at: cardIndex )
            refreshView()
            flipCount += 1
        }
        else
        {
            // covers the eventuality that a button wasn't linked up
        }

    }
    
    
    func refreshView()
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
    
    func toEmoji( for card : Card ) -> String
    {
        if emojiDict[ card.id ] == nil, emojiChoices.count > 0
        {
            let randomIndex = Int( arc4random_uniform( UInt32( emojiChoices.count ) ) )
            emojiDict[ card.id ] = emojiChoices.remove( at : randomIndex )
        }
        return emojiDict[ card.id ] ?? "?"
    }
    
}

