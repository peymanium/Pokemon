//
//  Pokemon.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/23/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Pokemon
{
    private var _pokemonName : String!
    private var _pokemonID : Int!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _baseAttack : String!
    private var _description : String!
    private var _type : String!
    private var _nextEvolutionText : String!
    private var _nextEvolutionImageID : String!
    private var _pokemonURL : String!
    
    //Getter / Setter methods
    
    var pokemonName : String
        {
        if self._pokemonName == nil
        {
            self._pokemonName = ""
        }
        return self._pokemonName
    }
    var pokemonID : Int
        {
        if self._pokemonID == nil
        {
            self._pokemonID = 0
        }
        return self._pokemonID
    }
    var pokemonDescription : String
    {
        if self._description == nil
        {
            self._description = ""
        }
        return self._description
    }
    var type : String
    {
        if self._type == nil
        {
            self._type = ""
        }
        return self._type
    }
    var defense : String
    {
        if self._defense == nil
        {
            self._defense = ""
        }
        return self._defense
    }
    var height : String
    {
        if self._height == nil
        {
            self._height = ""
        }
        return self._height
    }
    var weight : String
    {
        if self._weight == nil
        {
            self._weight = ""
        }
        return self._weight
    }
    var baseAttack : String
    {
        if self._baseAttack == nil
        {
            self._baseAttack = ""
        }
        return self._baseAttack
    }
    var nextEvolutionText : String
    {
        if self._nextEvolutionText == nil
        {
            self._nextEvolutionText = ""
        }
        return self._nextEvolutionText
    }
    var nextEvolutionImageID : String
    {
        if self._nextEvolutionImageID == nil
        {
            self._nextEvolutionImageID = ""
        }
        return self._nextEvolutionImageID
    }
    
    
    
    
    init(name : String, id: Int)
    {
        self._pokemonID = id
        self._pokemonName = name
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMAM)\(self.pokemonID)"
    }
    
    
    
    //Download Data function
    
    //This function we will use partially AlamoFire and partially NSUIRLSession
    //DownloadCompletedHandler is a typealias function for handling when our data download completed
    func DownloadData(completedHandler : DownloadCompletedHandler)
    {
        
        let url = NSURL(string: self._pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let jSonDictionary = response.result.value as? Dictionary<String,AnyObject>
            {
                
                if let height = jSonDictionary["height"] as? String
                {
                    self._height = height
                    print ("height: \(self._height)")
                }
                if let weight = jSonDictionary["weight"] as? String
                {
                    self._weight = weight
                    print ("weight: \(self._weight)")
                }
                if let attack = jSonDictionary["attack"] as? Int
                {
                    self._baseAttack = "\(attack)"
                    print ("attack: \(self._baseAttack)")
                }
                if let defense = jSonDictionary["defense"] as? Int
                {
                    self._defense = "\(defense)"
                    print ("defense: \(self._defense)")
                }
                
                
                
                //types
                if let typesArray = jSonDictionary["types"] as? [Dictionary<String, String>] where typesArray.count > 0
                {
                    self._type = typesArray[0]["name"]?.capitalizedString //get the first type
                    
                    if typesArray.count > 1
                    {
                        for index in 1...typesArray.count-1
                        {
                            let type = typesArray[index]["name"]!
                            
                            self._type = self._type + "/\(type.capitalizedString)"
                        }
                    }
                    print ("types: \(self._type)")
                }
                else
                {
                    self._type = ""
                }
                
                
                
                //description
                if let pokemonDescriptionArray = jSonDictionary["descriptions"] as? [Dictionary<String,String>] where pokemonDescriptionArray.count > 0
                {
                    if let descriptionUri = pokemonDescriptionArray[0]["resource_uri"]
                    {
                        let descriptionUrl = NSURL(string : "\(URL_BASE)\(descriptionUri)")!
                        
                        let urlSession = NSURLSession.sharedSession()
                        
                        urlSession.dataTaskWithURL(descriptionUrl, completionHandler: { (data : NSData?, response : NSURLResponse?, error : NSError?) in
                            
                            do
                            {
                                let jSonDescription = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                                
                                if let desc = jSonDescription["description"] as? String
                                {
                                    self._description = desc
                                    print ("description: \(self._description)")
                                    
                                    //When our download completed
                                    completedHandler()
                                }
                                
                            }
                            catch
                            {
                                print (error)
                            }
                            
                            
                        }).resume()
                    }
                }
                
                
                
                //Next Evolution
                if let evolutionArray = jSonDictionary["evolutions"] as? [Dictionary<String, AnyObject>] where evolutionArray.count > 0
                
                {
                    
                    if let to = evolutionArray[0]["to"] as? String
                    {
                        //Can't support mega pokemon right now but
                        //api still has mega data
                        if to.rangeOfString("mega") == nil
                        {
                            
                            var evolutionID = evolutionArray[0]["resource_uri"] as? String
                            evolutionID = evolutionID?.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                            evolutionID =  evolutionID?.stringByReplacingOccurrencesOfString("/", withString: "")
                            
                            self._nextEvolutionImageID = evolutionID
                            self._nextEvolutionText = to
                            
                            print ("evolution: \(self._nextEvolutionText)")
                            print ("evolution id: \(self._nextEvolutionImageID)")
                        }
                    }
                    
                }
                else
                {
                    self._nextEvolutionText = ""
                    self._nextEvolutionImageID = "\(self._pokemonID)"
                }
                
                
            }
            
        }
        
    }
    
}