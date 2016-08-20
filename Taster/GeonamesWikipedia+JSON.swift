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

    static func parseJSON (_ jsonObj:[String:AnyObject]) -> GeonamesWikipedia? {
        if let title = jsonObj["title"] as? String {
            if let summary = jsonObj["summary"] as? String {
                if let feature = jsonObj["feature"] as? String {
                    if let lat = jsonObj["lat"] as? Double {
                        if let lng = jsonObj["lng"] as? Double {
                            let url = URL(string:"http://" + (jsonObj["wikipediaUrl"]! as! String))
                            let loc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                            return GeonamesWikipedia(title: title, summary: summary, feature: feature, url: url as URL?, coordinate: loc)
                        }
                    }
                }
            }
        }
        return nil
    }
}
