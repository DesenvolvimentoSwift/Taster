//
//  RepositoryProtocol.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation

protocol RepositoryProtocol {
    func createFoodWithName(_ name:String, local:String) -> Food
    func favouriteFood() -> [Food]
    func foodByDate() -> [Food]
    func foodSearch(_ search:String) -> [Food]
    
    func mediaPath() -> String
}
