//
//  GeonamesPOI+XML.swift
//  Taster
//
//  Created by Luis Marcelino on 28/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

class GeonamesPOIXMLParserDelegate: NSObject, NSXMLParserDelegate {
    
    var POIs:[GeonamesPOI]?

    var currentTag:String?
    var values = [String:String]()

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentTag = elementName
    }

    func parser(parser: NSXMLParser, foundCharacters string: String) {
        guard let tag = currentTag else {
            return;
        }
        if let currentValue = values[tag] {
            values[tag] = currentValue + string
        }
        else {
            values[tag] = string
        }
    }
    

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "poi" {
            if let name = values["name"] {
                if let typeName = values["typeName"] {
                    if let latStr = values["lat"] {
                        if let lngStr = values["lng"] {
                            let poi = GeonamesPOI(name: name, typeName: typeName, coordinate: CLLocationCoordinate2D(latitude: Double(latStr)!, longitude: Double(lngStr)!))
                            if POIs == nil {
                                POIs = []
                            }
                            POIs!.append(poi)
                        }
                    }
                }
            }
            values = [:]
        }
        else {
            currentTag = nil
        }
    }
}