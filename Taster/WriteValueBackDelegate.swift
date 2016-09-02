//
//  WriteValueBackDelegate.swift
//  Taster
//
//  Created by Catarina Silva on 01/09/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import Foundation
import CoreLocation

protocol WriteValueBackDelegate {
    func writeValueBack(_ value: CLLocationCoordinate2D?)
}
