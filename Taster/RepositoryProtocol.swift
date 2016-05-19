//
//  RepositoryProtocol.swift
//  Taster
//
//  Created by Catarina Silva on 19/05/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    func createFoodWithName(name:String, local:String) -> Food
    func favouriteFood() -> [Food]
    func foodByDate() -> [Food]
    func foodSearch(search:String) -> [Food]
}