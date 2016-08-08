//
//  GeonamesWikiTest.swift
//  Taster
//
//  Created by Luis Marcelino on 08/08/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import XCTest

class GeonamesWikiTest: XCTestCase {
    
    let jsonString = "{\"summary\": \"O Arco da Rua Augusta é um arco triunfal situado na parte norte da Praça do Comércio, sobre a Rua Augusta, em Lisboa, Portugal. A sua construção foi programada em 1759, no quadro da reconstrução pombalina após a destruição da baixa lisboeta pelo terramoto de 1755, com desenho de Eugénio dos Santos (...)\", \"elevation\": 12, \"feature\": \"landmark\", \"lng\": -9.1368, \"distance\": \"0.0216\", \"countryCode\": \"PT\", \"rank\": 84, \"lang\": \"pt\", \"title\": \"Arco da Rua Augusta\", \"lat\": 38.7084, \"wikipediaUrl\": \"pt.wikipedia.org/wiki/Arco_da_Rua_Augusta\" }"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonParse() {
        if let data = self.jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let jsonObj = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)) as? [String:AnyObject] {
                let geoWiki = GeonamesWikipedia.parseJSON(jsonObj)
                XCTAssertNotNil(geoWiki)
                XCTAssertEqual("Arco da Rua Augusta", geoWiki?.title)
            }
        }
        else {
            XCTFail("Could not create data from input")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            self.testJsonParse()
        }
    }
    
}
