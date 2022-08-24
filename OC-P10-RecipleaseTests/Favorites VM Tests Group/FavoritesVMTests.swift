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
    
    func testClear() {
        sut.clearDataBase()
      
        XCTAssertEqual(managedContext.registeredObjects, Set([]))
    }
}
