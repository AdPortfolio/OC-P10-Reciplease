//
//  RecipesResponse.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation

typealias Recipes = [Recipe]

// MARK: - Response
struct RecipesResponse: Decodable {
    let hits: [Hit]
    // MARK: - Hit
    struct Hit: Decodable {
        let recipe: Recipe
    }
}

extension RecipesResponse.Hit: Equatable{}

extension RecipesResponse: Equatable {
    static func == (lhs: RecipesResponse, rhs: RecipesResponse) -> Bool {
        var bool = false
       
        if lhs.hits == rhs.hits && lhs.hits[0].recipe.label == rhs.hits[0].recipe.label {
            bool = true
        }
        return bool
    }
}
