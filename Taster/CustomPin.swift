//
//  CustomPin.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var food:Food
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, food:Food, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.food = food
        self.title = title
        self.subtitle = subtitle
    }
}
