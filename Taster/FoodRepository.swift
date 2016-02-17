//
//  FoodRepository.swift
//  Taster
//
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation

class FoodRepository {
    
    static var foods = [Food]()
    
    static func getNextId() -> Int {
        if let lastId = self.foods.last?.id {
            return lastId + 1
        }
        else {
            return 1
        }
    }
    
    static func createFoodWithName(name:String, local:String) -> Food {
        let id = getNextId()
        let f = Food(id: id, name: name, local: local)
        self.foods.append(f)
        return f
    }
    
    static func favouriteFood() -> [Food] {
        var fav = [Food]()
        for f in foods {
            if f.favourite {
                fav.append(f)
            }
        }
        return fav
    }
}