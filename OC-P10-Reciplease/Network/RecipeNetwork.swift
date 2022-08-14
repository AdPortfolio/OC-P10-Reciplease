//
//  RecipeNetwork.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation
import Alamofire

final class RecipeNetwork: RecipeNetworkType {
    
    private let apiKey = "748013fc4201871ede5c4b1399835527"
    private let apiAdress = "https://api.edamam.com/api/recipes/v2?"
    private var recipeQuery = "q="
    private var recipeName = ""
    private var appId = "&app_id="
    private var appIdValue = "1fb7f159"
    private var appKeyString = "&app_key="
    private var appKeyValue = "748013fc4201871ede5c4b1399835527"
    private var typeString = "&type="
    private var typeValue = "public"
        
    private func constructNameApiCall(with ingredients: String) -> String {
        apiAdress + recipeQuery + ingredients + appId + appIdValue + appKeyString + appKeyValue + typeString + typeValue
    }

    func fetchRecipes(with ingredients: String, completion: @escaping (Result<RecipesResponse?, Error>) -> ()) {
        let stringURL = constructNameApiCall(with: ingredients)
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: RecipesResponse.self) { (response) in
                guard let recipes = response.value else {
                    return
                }
                completion(.success(recipes))
            }
    }
}
