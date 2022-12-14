//
//  DetailsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import Foundation

final class DetailsViewModel {
    // MARK: - Properties
    var recipeCellViewModel: RecipeCellViewModel!
    var recipes: [Recipe]!
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var ingredientsLabelUpdater: ((String) -> Void)?
    
    var mealLabelUpdater: ((String) -> Void)?
    var recipeTextViewUpdater: ((String) -> Void)?
    var imageUpdater: ((String) -> Void)?
    var yieldUpdater: ((String) -> Void)?
    var totalTimeUpdater: ((String) -> Void)?
    var favoritesUpdater: ((Bool) -> Void)?
    var getDirectionsButtonUpdater: ((String) -> Void)?
    var isFavoredLabelUpdater: ((String) -> Void)?
    
    var didUnfavorBarButton: (() -> Void)?
    var didFavorBarButton: (() -> Void)?
    
    init(recipeCellViewModel: RecipeCellViewModel) {
        self.recipeCellViewModel = recipeCellViewModel
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        var info = [String:[Recipe]]()
        info["recipes"]?.append(contentsOf: recipes!)
        NotificationCenter.default.post(name: Notification.Name("Favorites"), object: nil, userInfo: info)
        
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
        mealLabelUpdater?(recipeCellViewModel.label)
        ingredientsLabelUpdater?("Ingredients")
        recipeTextViewUpdater?(recipeCellViewModel.ingredientLines.joined(separator: "\n - "))
        imageUpdater?((recipeCellViewModel.image))
        getDirectionsButtonUpdater?("Get Directions")
        isFavoredLabelUpdater?("Recipe saved to Favorites!")
        
        let yield = recipeCellViewModel.yield
        let stringedYield = String(yield)
        yieldUpdater?(stringedYield)
        
        let totalTime = recipeCellViewModel.totalTime
        let stringedTotalTime = String(totalTime)
        totalTimeUpdater?(stringedTotalTime)
        didUnfavorBarButton?()
        bindToRecipe()
        addRecipe()
    }

    func checkExistence() {
        Recipe.checkExistence(recipeCellVM: recipeCellViewModel)
    }

    func addRecipe() {
        Recipe.addRecipe(recipeCellVM: recipeCellViewModel)
    }
    
    func removeRecipe() {
        Recipe.removeRecipe(recipeCellVM: recipeCellViewModel)
    }
    
    func bindToRecipe() {
        Recipe.didUnfavorBarButton = {
            self.didUnfavorBarButton?()
        }
        
        Recipe.didFavorBarButton = {
            self.didFavorBarButton?()
        }
    }
}
