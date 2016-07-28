//
//  GeonamesClient.swift
//  Taster
//
//  Created by Luis Marcelino on 28/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

class GeonamesClient {
    
    static func findNearbyWikipedia (loc:CLLocationCoordinate2D, completionHandler:([GeonamesWikipedia]?) -> Void) {
        let urlString = "http://api.geonames.org/findNearbyWikipediaJSON?lat=\(loc.latitude)&lng=\(loc.longitude)&lang=PT&username=desenvolvimentoswift"
        if let url = NSURL(string:urlString) {
            let session = NSURLSession.sharedSession()
            let sessionTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                if data != nil {
                    if let jsonDic = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String:AnyObject] {
                        if let geonamesArray = jsonDic["geonames"] as? [[String:AnyObject]] {
                            var wikiEntries = [GeonamesWikipedia]()
                            for jsonObj in geonamesArray {
                                if let entry = GeonamesWikipedia.parseJSON(jsonObj) {
                                    wikiEntries.append(entry)
                                }
                            }
                            completionHandler(wikiEntries)
                            return
                        }
                    }
                }
                completionHandler(nil) // poderia ser passado o motivo por não haver dados
            })
            sessionTask.resume()
        }
    }
    
    static func findNearbyPOI (loc:CLLocationCoordinate2D, completionHandler:([GeonamesPOI]?) -> Void) {
        let urlString = "http://api.geonames.org/findNearbyPOIsOSM?lat=\(loc.latitude)&lng=\(loc.longitude)&lang=PT&username=desenvolvimentoswift"
        if let url = NSURL(string: urlString) {
            let session = NSURLSession.sharedSession()
            let sessionTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                let dataString = String(data)
                print(dataString);
            })
            sessionTask.resume()
        }
    }

}