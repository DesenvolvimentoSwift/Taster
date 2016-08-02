//
//  GeonameWikipedia+JSON.swift
//  Taster
//
//  Created by Luis Marcelino on 27/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

extension GeonamesWikipedia {

    static func parseJSON (jsonObj:[String:AnyObject]) -> GeonamesWikipedia? {
        if let title = jsonObj["title"] as? String {
            if let summary = jsonObj["summary"] as? String {
                if let feature = jsonObj["feature"] as? String {
                    if let lat = jsonObj["lat"] as? Double {
                        if let lng = jsonObj["lng"] as? Double {
                            let url = NSURL(string:"http://" + (jsonObj["wikipediaUrl"]! as! String))
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