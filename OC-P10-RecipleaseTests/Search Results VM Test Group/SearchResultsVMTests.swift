//
//  OC_P10_RecipleaseTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import XCTest
import Foundation
@testable import OC_P10_Reciplease


class SearchResultsVMTests: XCTestCase {
    
    var sut: SearchResultsViewModel!
    var network: RecipeNetworkType!

    override func setUpWithError() throws {
        network = MockRecipesNetwork(label: "", image: "", url: "", yield: 0, ingredientsLines: [""], totalTime: 0)
        sut = SearchResultsViewModel(network: network, ingredients: "")
    }

    override func tearDownWithError() throws {
        network = nil
        sut = nil
    }
    
    func testGivenNoCallIsMade_WhenViewLoads_ThenLabelsAreSetCorrectly() {
        let expectation = self.expectation(description: "Incorrect data")
        let expectedResult = "Reciplease"

        sut.titleText = { title in
            XCTAssertEqual(title, expectedResult)
            expectation.fulfill()
        }
        sut.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
