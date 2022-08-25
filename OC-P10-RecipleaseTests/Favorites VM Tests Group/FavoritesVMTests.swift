//
//  FavoritesVMTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import XCTest
@testable import OC_P10_Reciplease
import CoreData

class FavoritesVMTests: XCTestCase {
    
    var sut: FavoritesViewModel!
    var recipe: Recipe!
    var managedContext: NSManagedObjectContext!
   
    override func setUpWithError() throws {
        managedContext = PersistenceController.shared.container.viewContext
        recipe = Recipe(context: managedContext)
        sut = FavoritesViewModel(recipes: [recipe])
    }
    
    override func tearDownWithError() throws {
        managedContext = nil
        recipe = nil
        sut = nil
    }
    
    func testGivenDataBase_WhenClearDataBaseIsHit_ThenDataBaseIsCorrectlyCleared() {
        sut.clearDataBase()
        XCTAssertEqual(managedContext.registeredObjects, Set([]))
    }
    
    func testGivenRecipeCellModel_WhenRecipeCellViewModelIsCreated_ThenSavedRecipeIsCorrect() {
        managedContext = PersistenceController.shared.container.viewContext
        let recipe = Recipe(context: managedContext)
        let result = sut.createCellModel(recipe: recipe)
        
        let recipeCellVM = RecipeCellViewModel(label: "", image: "", url: "", yield: 0.0, ingredientLines: [], totalTime: 0.0, favorites: false)
        
        XCTAssertEqual(result, recipeCellVM)
    }
    
    func testGivenArrayOfRecipeCellViewModels_WhenARecipeIsChosen_ThenTheResultRecipeIsCorrect() {
        managedContext = PersistenceController.shared.container.viewContext
        let recipeCellVM = RecipeCellViewModel(label: "label", image: "image", url: "url", yield: 1.0, ingredientLines: ["ingredientLines"], totalTime: 0.1, favorites: false)
        sut.recipeCellViewModels = [recipeCellVM]
        let result = sut.getCellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(result, recipeCellVM)
    }
}
