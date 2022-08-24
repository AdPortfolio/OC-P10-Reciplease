//
//  DecodableTestCase.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import Foundation
import XCTest

protocol DecodableTestCase: AnyObject {
    associatedtype T: Decodable
    var sut: T! { get set }
}

extension DecodableTestCase {
    func recipesGivenSUTFromJSON(fileName: String = "\(T.self)") throws {
        let decoder = JSONDecoder()
        let data = try Data.recipeFromJSON(fileName: fileName)
        sut = try decoder.decode(T.self, from: data)
    }

    func productsGivenSUTFromJSON(fileName: String = "\(T.self)") throws {
        let decoder = JSONDecoder()
        let data = try Data.codeBarFromJSON(fileName: fileName)
        sut = try decoder.decode(T.self, from: data)
    }
}
