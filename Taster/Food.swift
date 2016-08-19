//
//  Food.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation
import CoreLocation

class Food {
    let id:Int;
    var name:String;
    var ingredients:[String]?
    var local:String;
    
    var foodDescription:String?
    var mediaFile:String?
    var rating:Int?
    var favourite = false
    var updated_at = Date()
    
    var location:CLLocationCoordinate2D?
    
    init(id:Int, name:String, local:String) {
        self.id = id
        self.name = name
        self.local = local
    }
    
}
