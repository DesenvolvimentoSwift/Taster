//
//  FoodRepository+Seeder.swift
//  Taster
//
//  Created by Luis Marcelino on 07/06/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation

extension RepositoryProtocol {
    func populate() {
        FoodRepository.repository.createFoodWithName("Costeta", local: "Mirandela")
        FoodRepository.repository.createFoodWithName("Francesinha", local: "Porto")
        FoodRepository.repository.createFoodWithName("Ovos moles", local: "Aveiro")
        FoodRepository.repository.createFoodWithName("Brisas do Liz", local: "Leiria")
        FoodRepository.repository.createFoodWithName("Chanfana", local: "Santarém")
        FoodRepository.repository.createFoodWithName("D. Rodrigo", local: "Faro")
    }
}