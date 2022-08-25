//
//  CurrencyResponseTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease

class ProductsResponseTests: XCTestCase, DecodableTestCase {
    var sut: ProductsResponse!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        try! productsGivenSUTFromJSON()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Type Tests
    func testConformsToDecodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func testConformsToEquatable() {
        XCTAssertEqual(sut, sut)
    }
    
    func testDecodableSetsDocs() {
        XCTAssertNotNil(sut.products)
        XCTAssertEqual(sut.products.count, 1)
    }
}
