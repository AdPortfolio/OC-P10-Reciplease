//
//  DetailsVMTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease

class DetailsVMTests: XCTestCase {
    
    var sut: DetailsViewModel!

    override func setUpWithError() throws {
        let recipeVM = RecipeCellViewModel(label: "",
                                           image: "",
                                           url: "",
                                           yield: 1.0,
                                           ingredientLines: [""],
                                           totalTime: 1.0,
                                           favorites: false)
        sut = DetailsViewModel(recipeCellViewModel: recipeVM)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGivenViewModel_WhenViewModelIsHit_ThenOutputIsCorrect() {
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
