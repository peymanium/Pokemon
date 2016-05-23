//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/23/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell
{
    @IBOutlet weak var LBL_Name : UILabel!
    @IBOutlet weak var IMG : UIImageView!
    
    
    func ConfigureCell(pokemon : Pokemon)
    {
        self.LBL_Name.text = pokemon.pokemonName
        self.IMG.image = UIImage(named: "\(pokemon.pokemonID)")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
