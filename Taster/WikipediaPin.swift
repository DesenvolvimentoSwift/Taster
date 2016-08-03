//
//  WikipediaPin.swift
//  Taster
//
//  Created by Luis Marcelino on 03/08/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation

import Foundation
import MapKit

class WikipediaPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return geoWiki.coordinate
    }

    var geoWiki: GeonamesWikipedia

    var title:String? {
        return geoWiki.title
    }
    
    var subtitle: String? {
        return geoWiki.feature
    }
    
    init(geoWiki:GeonamesWikipedia) {
        self.geoWiki = geoWiki
    }
}
