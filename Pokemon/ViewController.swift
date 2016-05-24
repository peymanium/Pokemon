//
//  ViewController.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/23/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var BTN_Music: UIButton!
    
    var pokemonArray = [Pokemon]()
    var pokemonSearch = [Pokemon]()
    var isSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        self.searchBar.returnKeyType = .Done
        
        Functions.instance.InitMusic()
        pokemonArray = Functions.instance.ParseCSV()
    }
    
    
    //CollectionView delegates
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if isSearchMode
        {
            return pokemonSearch.count
        }
        
        return pokemonArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        if let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as? PokemonCell
        {
            let pokemon : Pokemon!
            if isSearchMode
            {
                pokemon = pokemonSearch[indexPath.row]
            }
            else
            {
                pokemon = pokemonArray[indexPath.row]
            }
           
            cell.ConfigureCell(pokemon)
            
            return cell
        }
        else
        {
            return PokemonCell()
        }
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(100, 100)
    }
    
    
    //Search bar delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if self.searchBar.text == nil || self.searchBar.text == ""
        {
            self.isSearchMode = false
            view.endEditing(true)
        }
        else
        {
            self.isSearchMode = true
            let lowerSearchString = self.searchBar.text!.lowercaseString
            pokemonSearch = pokemonArray.filter({$0.pokemonName.rangeOfString(lowerSearchString) != nil})
        }
        self.collectionView.reloadData()
    }
    
    //Music button
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

