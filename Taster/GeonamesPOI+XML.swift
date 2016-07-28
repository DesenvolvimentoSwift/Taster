//
//  GeonamesPOI+XML.swift
//  Taster
//
//  Created by Luis Marcelino on 28/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

extension GeonamesPOI {
    
    static func parseXML (jsonObj:[String:AnyObject]) -> GeonamesPOI? {
        if let name = jsonObj["title"] as? String {
            if let type = jsonObj["summary"] as? String {
                if let lat = jsonObj["lat"] as? Double {
                    if let lng = jsonObj["lng"] as? Double {
                        let loc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        return GeonamesPOI(name: name, typeName: type, coordinate: loc)
                    }
                }
            }
        }
        return nil
    }

}