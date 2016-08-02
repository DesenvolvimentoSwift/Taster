//
//  GeonamePOI.swift
//  Taster
//
//  Created by Luis Marcelino on 27/07/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

/**
 * Exemplo de uma entrada em XML
 *
 
 <poi>
    <name>Ginginha do Carmo</name>
    <typeClass>amenity</typeClass>
    <typeName>cafe</typeName>
    <lng>-9.1358968</lng>
    <lat>38.7083873</lat>
    <distance>0.08</distance>
 </poi>
 
*/

struct GeonamesPOI {
    let name:String
    let typeName:String
    
    let coordinate: CLLocationCoordinate2D
}