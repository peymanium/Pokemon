//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/25/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var LBL_ID: UILabel!
    @IBOutlet weak var LBL_Name: UILabel!
    @IBOutlet weak var SEG: UISegmentedControl!
    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var LBL_Description: UILabel!
    @IBOutlet weak var LBL_Type: UILabel!
    @IBOutlet weak var LBL_Defense: UILabel!
    @IBOutlet weak var LBL_Height: UILabel!
    @IBOutlet weak var LBL_Weight: UILabel!
    @IBOutlet weak var LBL_BaseAttack: UILabel!
    @IBOutlet weak var LBL_NextEvolution: UILabel!
    @IBOutlet weak var IMG_CurrentEvolution: UIImageView!
    @IBOutlet weak var IMG_NextEvolution: UIImageView!
    @IBOutlet weak var AIV_Loading: UIActivityIndicatorView!
    @IBOutlet weak var VIEW_Loading: UIView!
    
    var pokemonDetails : Pokemon!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.LBL_Name.text = pokemonDetails.pokemonName
        
        self.AIV_Loading.startAnimating()
        self.AIV_Loading.alpha = 1.0
        self.VIEW_Loading.alpha = 1.0
        
        //start loding data from WebService
        pokemonDetails.DownloadData {
            //When download complted
            self.LoadUI()
        }
        
    }
    
    func LoadUI()
    {
        let image = UIImage(named: "\(pokemonDetails.pokemonID)")!
        self.IMG_CurrentEvolution.image = image
        self.IMG.image = image

        self.LBL_Type.text = pokemonDetails.type
        self.LBL_Height.text = pokemonDetails.height
        self.LBL_Weight.text = pokemonDetails.weight
        self.LBL_Defense.text = pokemonDetails.defense
        self.LBL_Description.text = pokemonDetails.pokemonDescription
        self.LBL_BaseAttack.text = pokemonDetails.baseAttack
        self.LBL_NextEvolution.text = pokemonDetails.nextEvolutionText
        self.IMG_NextEvolution.image = UIImage(named: pokemonDetails.nextEvolutionImageID)
        
        self.AIV_Loading.stopAnimating()
        self.AIV_Loading.alpha = 0
        self.VIEW_Loading.alpha = 0
    }
    
    
    @IBAction func BTN_Back_Tapped(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
