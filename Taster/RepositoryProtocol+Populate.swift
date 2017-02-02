//
//  FoodRepository+Seeder.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation

extension RepositoryProtocol {
    func populate() {
        let _ = FoodRepository.repository.createFoodWithName("Costeta", local: "Mirandela")
        let _ = FoodRepository.repository.createFoodWithName("Francesinha", local: "Porto")
        let _ = FoodRepository.repository.createFoodWithName("Ovos moles", local: "Aveiro")
        let _ = FoodRepository.repository.createFoodWithName("Brisas do Liz", local: "Leiria")
        let _ = FoodRepository.repository.createFoodWithName("Chanfana", local: "Santarém")
        let _ = FoodRepository.repository.createFoodWithName("D. Rodrigo", local: "Faro")
    }
}
