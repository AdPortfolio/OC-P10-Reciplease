//
//  RecipeNetworkType.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation

protocol RecipeNetworkType {
    func fetchRecipes(with ingredients: String, completion: @escaping (Result<RecipesResponse?, Error>) -> ())
}
