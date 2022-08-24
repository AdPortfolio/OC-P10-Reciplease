//
//  ProductsAPINetworkTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import XCTest
import Foundation
@testable import OC_P10_Reciplease

class ProductsAPINetworkTests: XCTestCase {
    
    var products: [Product]!
    var sut: SearchViewModel!
    var productsMock: MockProductsNetwork!
    
    override func setUpWithError() throws {
        let products = Product(categoriesTags: [
            "en:plant-based-foods-and-beverages",
            "en:beverages",
            "en:plant-based-beverages",
            "en:tea-based-beverages",
            "en:iced-teas"
        ], productName: "Iced Tea Saveur Pêche")
        productsMock = MockProductsNetwork(products: [products])
        sut = SearchViewModel(network: productsMock)
    }

    override func tearDownWithError() throws {
        productsMock = nil
        sut = nil
    }

    func testGivenCodeBar_WhenSearchIsLaunched_ThenResultIsAsExpected() {
        sut.fetchProducts(with: "9120115731413")
        XCTAssertEqual(sut.componentsArray, ["plant-based-foods-and-beverages",
                       "beverages",
                       "plant-based-beverages",
                       "tea-based-beverages",
                       "iced-teas"])
    }
}
