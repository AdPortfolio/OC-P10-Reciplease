//
//  RecipesResponseTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease

class RecipesResponseTests: XCTestCase, DecodableTestCase { // 2
    
    var jsonResp: RecipesResponse! // 3
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        try! recipesGivenSUTFromJSON() // 4
    }
    
    override func tearDownWithError() throws {
        jsonResp = nil // 5
        try super.tearDownWithError()
    }
    
    // MARK: - Type Tests
    func testConformsToDecodable() { // 6
        XCTAssertTrue((jsonResp as Any) is Decodable) // cast silences a warning
    }
    
    func testConformsToEquatable() { // 7
        XCTAssertEqual(jsonResp, jsonResp) // requires Equatable conformance
    }
    
    func testDecodableSetsDocs() { // 8
        XCTAssertNotNil(jsonResp.hits[0].recipe.label)
        XCTAssertEqual(jsonResp.hits.count, 1)
    }
}
