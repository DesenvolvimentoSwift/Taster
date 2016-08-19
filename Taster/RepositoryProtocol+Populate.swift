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
        FoodRepository.repository.createFoodWithName("Costeta", local: "Mirandela")
        FoodRepository.repository.createFoodWithName("Francesinha", local: "Porto")
        FoodRepository.repository.createFoodWithName("Ovos moles", local: "Aveiro")
        FoodRepository.repository.createFoodWithName("Brisas do Liz", local: "Leiria")
        FoodRepository.repository.createFoodWithName("Chanfana", local: "Santarém")
        FoodRepository.repository.createFoodWithName("D. Rodrigo", local: "Faro")
    }
}
