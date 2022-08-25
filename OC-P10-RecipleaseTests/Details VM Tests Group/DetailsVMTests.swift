//
//  DetailsVMTests.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//
import CoreData
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
    
    func testGivenOneRecipe_WhenWeWantToCheckIfTheSameExistsInMemory_ThenReturnedAnswerIsCorrect() {
        let managedObjectContext = setUpInMemoryManagedObjectContext()
        _ = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: managedObjectContext)
       
        let recipeCellVM = RecipeCellViewModel(label: "", image: "", url: "", yield: 1.0, ingredientLines: [""], totalTime: 0.1, favorites: false)
        sut.checkExistence()
        
        XCTAssertEqual(managedObjectContext.registeredObjects.count, [recipeCellVM].count)
    }
    
    func testSavedRecipe_WhenAskedToDelete_ThenRecipeIsCorrectlyDeletedFromMemory() {
        let managedObjectContext = setUpInMemoryManagedObjectContext()
       _ = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: managedObjectContext)
        
        let recipeCellVM = RecipeCellViewModel(label: "", image: "", url: "", yield: 1.0, ingredientLines: [""], totalTime: 0.1, favorites: false)
        sut.recipeCellViewModel = recipeCellVM
        sut.addRecipe()
        try? managedObjectContext.save()
        print(managedObjectContext.registeredObjects)
        sut.removeRecipe()
       
        XCTAssertEqual(managedObjectContext.registeredObjects.count, 0)
    }
}
