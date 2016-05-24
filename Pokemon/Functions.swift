//
//  Functions.swift
//  Pokemon
//
//  Created by Peyman Attarzadeh on 5/24/16.
//  Copyright © 2016 PeymaniuM. All rights reserved.
//

import Foundation


class Functions
{
    static let instance = Functions()
    
    
    func ParseCSV() -> [Pokemon]
    {
        var result = [Pokemon]()
        
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do
        {
            let csv = try CSV.init(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows
            {
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                result.append(Pokemon(name: name, id: id))
            }
            
        }
        catch let error as NSError
        {
            print (error.debugDescription)
        }
        
        
        return result
    }
    
}