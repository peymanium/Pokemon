//
//  Pokemon.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/23/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import Foundation

class Pokemon
{
    private var _pokemonName : String!
    private var _pokemonID : Int
    
    var pokemonName : String
        {
        return self._pokemonName
    }
    var pokemonID : Int
        {
        return self._pokemonID
    }
    
    init(name : String, id: Int)
    {
        self._pokemonID = id
        self._pokemonName = name
    }
    
}