//
//  SearchVMTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 23/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease

class SearchVMTests: XCTestCase {
    
    var network: MockProductsNetwork!
    var productsMock: MockProductsNetwork!
    var sut: SearchViewModel!
    
    override func setUpWithError() throws {
        let products = Product(categoriesTags: [
            "en:plant-based-foods-and-beverages",
            "en:beverages",
            "en:plant-based-beverages",
            "en:tea-based-beverages",
            "en:iced-teas"
        ], productName: "Iced Tea Saveur Pêche")
        network = MockProductsNetwork(products: [products])
        sut = SearchViewModel(network: network)
    }
    
    override func tearDown() async throws {
        network = nil
        sut = nil
    }
    
    func testGivenAnArrayOfIngredients_WhenIngredientsAreCleared_ThenIngredientsArrayIsEmpty() {
        sut.ingredientsArray = ["Lemon", "Pepper"]
        sut.clearIngredients()
        XCTAssertEqual(sut.ingredientsArray, [])
    }
    
    func testGivenOneIngredientInTextField_WhenAddIngredientIsHit_ThenIngredientIsFormattedCorrectly() {
        let expectation = self.expectation(description: "Incorrect data")
        let expectedResult = ["- Lemon"]
       
        
        sut.ingredientsArrayUpdater = { ingredient in
            XCTAssertEqual(ingredient, expectedResult)
            expectation.fulfill()
        }
        
        sut.addIngredient(with: "Lemon")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenSeveralIngredientsInTextField_WhenAddIngredientIsHit_ThenIngredientsAreFormattedCorrectly() {
        let expectation = self.expectation(description: "Incorrect data")
        let expectedResult = ["- Lemon", "- Salt", "- Pepper"]
       
        
        sut.ingredientsArrayUpdater = { ingredient in
            XCTAssertEqual(ingredient, expectedResult)
            expectation.fulfill()
        }
        
        sut.addIngredient(with: "Lemon, salt, pepper")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAnIngredien_WhenUpdateComponent_ThenOutputIsCorrect() {
        sut.ingredientsArray = []
        sut.updateComponent(component: "lemon")
        
        XCTAssertEqual(sut.ingredientsArray, ["- Lemon"])
    }
    
    func testGivenIngredients_WhenRemoveTwoCharectersIsHit_ThenOutputIsCorrect() {
        var lemon = "- Lemon"
        sut.removeTwoCharacters(from: &lemon)
        XCTAssertEqual(lemon, "Lemon")
    }
}
