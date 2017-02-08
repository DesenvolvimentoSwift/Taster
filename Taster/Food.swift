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

class Food : NSObject, NSCoding {
    let id:Int;
    var name:String;
    var ingredients:[String]?
    var local:String
    
    var foodDescription:String?
    var mediaFile:String?
    var rating:Int?
    var favourite = false
    var updated_at = Date()
    
    var location:CLLocationCoordinate2D? {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            if let coord = newValue {
                self.latitude = coord.latitude
                self.longitude = coord.longitude
            }
            else {
                self.latitude = 0
                self.longitude = 0
            }
        }
    }
    
    var latitude = Double()
    var longitude = Double()
    
    init(id:Int, name:String, local:String) {
        self.id = id
        self.name = name
        self.local = local
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(local, forKey: "local")
        aCoder.encode(foodDescription, forKey: "foodDescription")
        aCoder.encode(ingredients, forKey: "ing")
        aCoder.encode(mediaFile, forKey: "media")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(favourite, forKey: "fav")
        aCoder.encode(updated_at, forKey: "date")
        aCoder.encode(latitude, forKey: "lat")
        aCoder.encode(longitude, forKey: "long")
    }
    
    required init (coder aDecoder:NSCoder){
        id = aDecoder.decodeInteger(forKey: "id")
        name = aDecoder.decodeObject(forKey: "name") as! String
        local = aDecoder.decodeObject(forKey: "local") as! String
        foodDescription = aDecoder.decodeObject(forKey: "foodDescription") as? String
        ingredients = aDecoder.decodeObject(forKey: "ing") as? [String]
        mediaFile = aDecoder.decodeObject(forKey: "media") as? String
        //print(mediaFile)
        rating = aDecoder.decodeObject(forKey: "rating") as? Int
        favourite = aDecoder.decodeBool(forKey: "fav")
        updated_at = aDecoder.decodeObject(forKey: "date") as! Date
        
        latitude = aDecoder.decodeDouble(forKey: "lat")
        longitude = aDecoder.decodeDouble(forKey: "long")
    }

}
