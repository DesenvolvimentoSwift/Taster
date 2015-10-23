//
//  Food.swift
//  Taster
//
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import Foundation

class Food {
    let id:Int;
    var name:String;
    var local:String;

    var description:String?;
    var ingrediente:[String]?;
    var mediaFiles:[String]?;
    var rating:Int?;
    var favourite = false;
    var last_updatevar = NSDate();
    
    init(id:Int, name:String, local:String) {
        self.id = id;
        self.name = name;
        self.local = local;
    }
    
}