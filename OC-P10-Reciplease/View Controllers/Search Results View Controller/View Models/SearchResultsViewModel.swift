//
//  SearchResultsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation

final class SearchResultsViewModel: NSObject {
    
    var network: RecipeNetworkType!
    var ingredients: String
    
    // MARK: - Closures
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var ingredientsUpdater: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    
    var didGetDetails: ((RecipeCellViewModel) -> Void)?
    var recipeCellViewModels = [RecipeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(network: RecipeNetworkType, ingredients: String) {
        self.network = network
        self.ingredients = ingredients
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
        ingredientsUpdater?(ingredients)
    }

    func getCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModel {
        return recipeCellViewModels[indexPath.row]
    }
    
    func getRecipes(with ingredients: String) {
        network.fetchRecipes(with: ingredients) { result in
            switch result {
            case .success(let response):
                guard let safeResponse = response else {return}
                self.fetchData(recipes: safeResponse)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func fetchData(recipes: RecipesResponse) {
        var recipeViewModelsList = [RecipeCellViewModel]()
        for recipe in recipes.hits {
            recipeViewModelsList.append(createCellViewModel(recipe: recipe.recipe))
        }
        recipeCellViewModels = recipeViewModelsList
    }

    private func createCellViewModel(recipe: Recipe) -> RecipeCellViewModel {
        let label = recipe.label
        let ingredientsLines = recipe.ingredientLines
        let image = recipe.image
        let url = recipe.url
        let yield = recipe.yield
        let totalTime = recipe.totalTime
        let favorites = false
       
        return RecipeCellViewModel(label: label, image: image, url: url, yield: yield, ingredientLines: ingredientsLines , totalTime: totalTime, favorites: favorites)
    }
}
