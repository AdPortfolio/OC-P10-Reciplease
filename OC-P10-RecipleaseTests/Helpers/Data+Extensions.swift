//
//  Data+Extensions.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import Foundation
import XCTest

extension Data {
    
    public static func recipeFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "FakeRecipesData", withExtension: "json")!
        return try Data(contentsOf: url)
    }
    
    public static func codeBarFromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = bundle.url(forResource: "FakeCodeBarData", withExtension: "json")!
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass {}

