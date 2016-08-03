//
//  CustomPin.swift
//  Taster
//
//  Created by Catarina Silva on 08/04/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
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
