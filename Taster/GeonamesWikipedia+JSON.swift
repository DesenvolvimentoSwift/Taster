//
//  GeonameWikipedia+JSON.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation
import CoreLocation

extension GeonamesWikipedia {

    static func parse (json:[String:AnyObject]) -> GeonamesWikipedia? {
        if let title = json["title"] as? String {
            if let summary = json["summary"] as? String {
                if let feature = json["feature"] as? String {
                    if let lat = json["lat"] as? Double {
                        if let lng = json["lng"] as? Double {
                            let url = URL(string:"http://" + (json["wikipediaUrl"]! as! String))
                            let loc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                            return GeonamesWikipedia(title: title, summary: summary, feature: feature, url: url, coordinate: loc)
                        }
                    }
                }
            }
        }
        return nil
    }
}
