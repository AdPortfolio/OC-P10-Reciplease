//
//  FavoritesViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation
import CoreData

final class FavoritesViewModel: NSObject {
    
    private let notificationName = "Favorites"

    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    var recipesUpdater: (([Recipe]?) -> Void)?
    var didGetDetails: ((RecipeCellViewModel) -> Void)?
    var didInitViewModel: (() -> Void)?
    
    var lottieLabelUpdater: ((String) -> Void)?
    
    var didShowAnimation: (() -> Void)?
    var didHideAnimation: (() -> Void)?
    
    var recipes: [Recipe]?
    var didSendAlert: ((String, String) -> Void)?
    
    var recipeCellViewModels = [RecipeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        lottieLabelUpdater?("Add your favorite recipes...")
        recipesUpdater?(recipes)
        NotificationCenter.default.addObserver(self, selector: #selector(self.favoritesHaveChanged(notification:)), name: Notification.Name(notificationName), object: nil)
    }
    
    @objc func favoritesHaveChanged(notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let recipes = dict["recipes"] as? [Recipe] {
                self.recipes = recipes
                getRecipes()
            } else {
                print("empty saved recipes detected")
            }
        }
    }
    
    func getRecipes() {
        guard let recipes = recipes else {
            self.fetchData(recipes: [])
            return
        }
        self.fetchData(recipes: recipes)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func fetchData(recipes: [Recipe]) {
        var recipeViewModelsList = [RecipeCellViewModel]()
        let recipeFetch: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        recipeFetch.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(recipeFetch)
            self.recipes = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        for recipe in recipes {
            guard let recipe = createCellModel(recipe: recipe) else {return}
            recipeViewModelsList.append(recipe)
        }
        recipeCellViewModels = recipeViewModelsList
    }
    
    func createCellModel(recipe: Recipe) -> RecipeCellViewModel? {
        let label = recipe.label
        let image = recipe.image
        let url = recipe.url
        let yield = recipe.yield
        let ingredientsLines = recipe.ingredientLines
        let totalTime = recipe.totalTime
        let favorite = recipe.favorites
        
        return RecipeCellViewModel(label: label, image: image, url: url, yield: yield, ingredientLines: ingredientsLines, totalTime: totalTime, favorites: favorite)
    }
    
    func clearDataBase() {
        let managedContext = PersistenceController.shared.container.viewContext
        
        guard var recipes = recipes else {
            return
        }
        for (index,recipe) in recipes.enumerated().reversed() {
            recipes.remove(at: index)
            managedContext.delete(recipe)
        }
        
        self.recipes = recipes
        do {
            try managedContext.save()
        } catch  {
            didSendAlert?("Please Try again", "Issue")
        }
    }

    func getCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModel {
        return recipeCellViewModels[indexPath.row]
    }
}
