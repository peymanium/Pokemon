//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/25/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var LBL_Name: UILabel!
    
    var pokemonDetails : Pokemon!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.LBL_Name.text = pokemonDetails.pokemonName
    
    }

}
