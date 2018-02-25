//
//  Extensions.swift
//  Concentration
//
//  Created by Karljürgen on 2018-02-25.
//  Copyright © 2018 Schoolworks Software. All rights reserved.
//

import Foundation

extension Collection
{
    var single : Element?
    {
        return count == 1 ? first : nil
    }
}

extension Int
{
    var arc4random : Int
    {
        // count of possible return values should logically be greater than zero
        assert( self != 0, "Int.arc4random( \(self) )--- argument must be non-zero" )
        
        // test for special case of negative argument, return negative result
        if self < 0
        {
            return -Int( arc4random_uniform( UInt32( abs( self ) ) ) )
        }
        
        // default case
        return Int( arc4random_uniform( UInt32( self ) ) )
    }
}
