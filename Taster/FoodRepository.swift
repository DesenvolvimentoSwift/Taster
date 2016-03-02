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

    static func foodByDate() -> [Food] {
        var orderedFood = foods
        orderedFood.sortInPlace { (food1, food2) -> Bool in
            return food1.updated_at.compare(food2.updated_at) == .OrderedDescending
        }
        return orderedFood
    }
    
    static func foodSearch(search:String) -> [Food] {
        if search.characters.count == 0 {
            return foods
        }
        var searchedFoods = [Food]()
        for f in foods {
            if f.name.containsString(search) ||
                f.foodDescription?.containsString(search) == true ||
                f.local.containsString(search)
            {
                searchedFoods.append(f)
            }
        }
        return searchedFoods
    }
    
}