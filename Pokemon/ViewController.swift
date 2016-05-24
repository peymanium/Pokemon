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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    //CollectionView delegates
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as? PokemonCell
        {
            let pokemon = Pokemon(name: "Charzaar", id: indexPath.row)
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
    
    

}

