//
//  ViewController.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/23/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var collectionView : UICollectionView!
    
    @IBOutlet weak var BTN_Music: UIButton!
    var pokemonArray = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        Functions.instance.InitMusic()
        pokemonArray = Functions.instance.ParseCSV()
    }
    
    
    //CollectionView delegates
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as? PokemonCell
        {
            let pokemon = pokemonArray[indexPath.row]
            cell.ConfigureCell(pokemon)
            
            return cell
        }
        else
        {
            return PokemonCell()
        }
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    
    @IBAction func BTN_Music_Tapped(sender: AnyObject)
    {
        if Functions.instance.musicPlayer.playing
        {
            Functions.instance.musicPlayer.stop()
            self.BTN_Music.alpha = 0.4
        }
        else
        {
            Functions.instance.musicPlayer.play()
            self.BTN_Music.alpha = 1
        }
    }
    

}

