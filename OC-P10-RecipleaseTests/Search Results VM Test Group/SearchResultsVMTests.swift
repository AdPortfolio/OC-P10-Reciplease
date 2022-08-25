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
    
    func testArrayOfRecipeCellViewModels_WhenRecipeAskedForAParticularRow_ThenReturnedResultIsCorrect() {
        let recipeCellViewModel = RecipeCellViewModel(label: "label", image: "imageUrl", url: "recipeUrl", yield: 1.0, ingredientLines: ["ingredientLines"], totalTime: 0.1, favorites: false)
        sut.recipeCellViewModels = [recipeCellViewModel]
        let indexPath = IndexPath(row: 0, section: 0)
        let result = sut.getCellViewModel(at: indexPath).label
        
        XCTAssertEqual(result, recipeCellViewModel.label)
    }
}
