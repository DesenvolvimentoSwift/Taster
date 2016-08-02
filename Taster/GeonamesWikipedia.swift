//
//  GeonameWikipedia.swift
//  Taster
//
//  Created by Luis Marcelino on 27/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

/**
 * Exemplo de uma entrada em JSON
 *
 
 {
    "summary": "O Arco da Rua Augusta é um arco triunfal situado na parte norte da Praça do Comércio, sobre a Rua Augusta, em Lisboa, Portugal. A sua construção foi programada em 1759, no quadro da reconstrução pombalina após a destruição da baixa lisboeta pelo terramoto de 1755, com desenho de Eugénio dos Santos (...)",
    "elevation": 12,
    "feature": "landmark",
    "lng": -9.1368,
    "distance": "0.0216",
    "countryCode": "PT",
    "rank": 84,
    "lang": "pt",
    "title": "Arco da Rua Augusta",
    "lat": 38.7084,
    "wikipediaUrl": "pt.wikipedia.org/wiki/Arco_da_Rua_Augusta"
 }
 
 */
struct GeonamesWikipedia {
    let title:String
    let summary:String
    let feature:String

    let url:NSURL?
    
    let coordinate: CLLocationCoordinate2D
}