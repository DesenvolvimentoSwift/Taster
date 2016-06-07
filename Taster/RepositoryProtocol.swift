//
//  RepositoryProtocol.swift
//  Taster
//
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    func createFoodWithName(name:String, local:String) -> Food
    func favouriteFood() -> [Food]
    func foodByDate() -> [Food]
    func foodSearch(search:String) -> [Food]
    
    func mediaPath() -> String
}