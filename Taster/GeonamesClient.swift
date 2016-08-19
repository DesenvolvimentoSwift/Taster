//
//  GeonamesClient.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import Foundation
import CoreLocation

class GeonamesClient {
    
    static func findNearbyWikipedia (_ loc:CLLocationCoordinate2D, completionHandler:@escaping ([GeonamesWikipedia]?) -> Void) {
        let urlString = "http://api.geonames.org/findNearbyWikipediaJSON?lat=\(loc.latitude)&lng=\(loc.longitude)&lang=PT&username=desenvolvimentoswift"
        if let url = URL(string:urlString) {
            let session = URLSession.shared
            let sessionTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if data != nil {
                    if let jsonDic = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject] {
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
    
    static func findNearbyPOI (_ loc:CLLocationCoordinate2D, completionHandler:@escaping ([GeonamesPOI]?) -> Void) {
        let urlString = "http://api.geonames.org/findNearbyPOIsOSM?lat=\(loc.latitude)&lng=\(loc.longitude)&lang=PT&username=desenvolvimentoswift"
        if let url = URL(string: urlString) {
            let sessionConfig = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
            let sessionTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                // Extrair dados
                if data != nil {
                    let xmlParser = XMLParser(data: data!)
                    let delegate = GeonamesPOIXMLParserDelegate()
                    xmlParser.delegate = delegate
                    xmlParser.parse()
                    completionHandler (delegate.POIs)
                }
                else {
                    completionHandler(nil)
                }
                session.invalidateAndCancel()
            })
            sessionTask.resume()
        }
    }

}
