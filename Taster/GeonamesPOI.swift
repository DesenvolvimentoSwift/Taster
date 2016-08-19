//
//  GeonamePOI.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
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
