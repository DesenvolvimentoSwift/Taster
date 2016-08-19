//
//  WikipediaPin.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
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
