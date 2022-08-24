//
//  RecipesAPINetworkTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease
import CoreData

class RecipesAPINetworkTests: XCTestCase {
    
    var hits: [RecipesResponse.Hit]!
    var sut: SearchResultsViewModel!
    var recipesMock: MockRecipesNetwork!
    
    override func setUpWithError() throws {
        recipesMock = MockRecipesNetwork(label: "", image: "", url: "", yield: 1.0, ingredientsLines: ["String"], totalTime: 2.0)
        sut = SearchResultsViewModel(network: recipesMock, ingredients: "ingredient")
    }

    override func tearDownWithError() throws {
        recipesMock = nil
        sut = nil
    }

    func testGivenIngredient_WhenSearchIsLaunched_ThenResultIsAsExpected() {
        sut.getRecipes(with: "something")
        XCTAssertEqual(sut.recipeCellViewModels[0].label, "Lemon Pie")
    }
}
