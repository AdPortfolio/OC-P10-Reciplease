//
//  MockRecipesNetwork.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import Foundation
@testable import OC_P10_Reciplease

class MockRecipesNetwork{

    var label: String
    var image: String
    var url: String
    var yield: Float
    var ingredientsLines: [String]
    var totalTime: Float
    
    var recipeResponse: RecipeCellViewModel!
    
    init(label: String, image: String, url: String, yield: Float, ingredientsLines: [String], totalTime: Float) {
        self.label = label
        self.image = image
        self.url = url
        self.yield = yield
        self.ingredientsLines = ingredientsLines
        self.totalTime = totalTime
        self.recipeResponse = RecipeCellViewModel(label: "Hello", image: "it", url: "is", yield: 1, ingredientLines: ["Me"], totalTime: 11, favorites: false)
    }
}

extension MockRecipesNetwork: RecipeNetworkType {
    func fetchRecipes(with ingredients: String, completion: @escaping (Result<RecipesResponse?, Error>) -> ()) {
        guard self.recipeResponse != nil else {
            completion(.failure(ServiceError.noDataReceived))
            return
        }
        
        let decoder = JSONDecoder()

        do {
            let data = try Data.recipeFromJSON(fileName: "FakeRecipesData")
            let recipe = try decoder.decode(RecipesResponse.self, from: data)
            print(recipe)
            completion(.success(recipe))
        } catch _ {
            completion(.failure(ServiceError.recipeError))
        }
    }
}
