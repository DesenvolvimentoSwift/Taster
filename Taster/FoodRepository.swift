//
//  FoodRepository.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation

class FoodRepository:RepositoryProtocol {
    
    static let repository = FoodRepository() //shared instance
    fileprivate init() {}
    
    var foods = [Food]()
    
    fileprivate func getNextId() -> Int {
        if let lastId = self.foods.last?.id {
            return lastId + 1
        }
        else {
            return 1
        }
    }
    
    func createFoodWithName(_ name:String, local:String) -> Food {
        let id = getNextId()
        let f = Food(id: id, name: name, local: local)
        self.foods.append(f)
        return f
    }
    
    func favouriteFood() -> [Food] {
        var fav = [Food]()
        for f in foods {
            if f.favourite {
                fav.append(f)
            }
        }
        return fav
        
    }
    func foodByDate() -> [Food] {
        var orderedFood = foods
        orderedFood.sort { (food1, food2) -> Bool in
            return food1.updated_at.compare(food2.updated_at as Date) ==
                .orderedDescending
        }
        return orderedFood
    }
    func foodSearch(_ search:String) -> [Food] {
        if search.characters.count == 0 {
            return foods
        }
        var searchedFoods = [Food]()
        for f in foods {
            if f.name.contains(search) ||
                f.foodDescription?.contains(search) == true ||
                f.local.contains(search)
            {
                searchedFoods.append(f)
            }
        }
        return searchedFoods
        
    }
    
    static func mediaPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0];
    }
}
