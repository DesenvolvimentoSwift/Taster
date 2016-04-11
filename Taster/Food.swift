//
//  Food.swift
//  Taster
//
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

class Food {
    let id:Int;
    var name:String;
    var local:String;

    var foodDescription:String?;
    var ingredientes:[String]?;
    var mediaFiles:[String]?;
    var rating:Int?;
    var favourite = false;
    var updated_at = NSDate();
    
    var location:CLLocationCoordinate2D?
    
    init(id:Int, name:String, local:String) {
        self.id = id;
        self.name = name;
        self.local = local;
    }
    
    func ingredientesString() -> String {
        if ingredientes == nil {
            return "";
        }
        return ingredientes!.joinWithSeparator(", ")
    }
    
}