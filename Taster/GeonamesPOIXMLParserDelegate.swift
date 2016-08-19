//
//  GeonamesPOI+XML.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation
import CoreLocation

class GeonamesPOIXMLParserDelegate: NSObject, XMLParserDelegate {
    
    var POIs:[GeonamesPOI]?

    var currentTag:String?
    var values = [String:String]()

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentTag = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
    

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
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
