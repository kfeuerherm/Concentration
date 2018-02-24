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
    var emojiChoices = [ "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️", "👻", "🎃", "💀", "😈", "☠️" ]
    
    var flipCount = 0 { didSet { flipCountLabel.text = "\(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [ UIButton ]!
    
    @IBAction func touchCard( _ sender: UIButton )
    {
        
        if let cardIndex = cardButtons.index( of: sender )
        {
            flipCard( withEmoji: emojiChoices[ cardIndex ], on: sender )
            flipCount += 1
        }
        else
        {
            print( "chosen card was not in cardButtons" )
        }

    }
    
    func flipCard( withEmoji emoji: String, on button: UIButton )
    {
        
        if button.currentTitle == emoji
        {
            button.setTitle( "", for: UIControlState.normal )
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        else
        {
            button.setTitle(emoji, for: UIControlState.normal )
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    
}

