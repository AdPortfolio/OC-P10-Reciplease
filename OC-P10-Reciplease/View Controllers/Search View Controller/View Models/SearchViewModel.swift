//
//  SearchViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation

final class SearchViewModel: NSObject {
    
    private var network: ProductsNetworkType!
    var componentsArray: [String] = []

    init(network: ProductsNetworkType) {
        self.network = network
    }
    // MARK: - Properties
    var ingredientsArray = [String]()
    var searchIngredients: String = ""
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var fridgeLabelUpdater: ((String) -> Void)?
    var ingredientsLabelUpdater: ((String) -> Void)?
    var searchLabelUpdater: ((String) -> Void)?
    
    var ingredientsArrayUpdater: (([String]) -> Void)?
    var searchIngredientsUpdater: ((String) -> Void)?
    var clearButtonUpdater: ((String) -> Void)?
    var addButtonUpdater: ((String) -> Void)?
    var lottieLabelUpdater: ((String) -> Void)?
    
    var didShowHidePickerView: (() -> Void)?
    var didPickerViewReloadAllComponents: (() -> Void)?
    var didPresentAlert: ((Error) -> Void)?
        
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
        fridgeLabelUpdater?("What's in your fridge ?")
        ingredientsLabelUpdater?("Your ingredients :")
        clearButtonUpdater?("Clear")
        addButtonUpdater?("Add")
        lottieLabelUpdater?("Add some ingredients..")
        searchLabelUpdater?("Search for recipes")
        ingredientsArrayUpdater?(ingredientsArray)
    }
    
    func clearIngredients() {
        ingredientsArray.removeAll()
        ingredientsArrayUpdater?(ingredientsArray)
        searchIngredients = ""
    }
    
    func addIngredient(with textFieldText: String) {
        let temporaryArray = textFieldText.components(separatedBy: ", ")
        
        if !ingredientsArray.contains("- \(textFieldText)")  {
            for ingredient in temporaryArray {
                let modifiedText = "- \(ingredient.capitalizingFirstLetter())"
                ingredientsArray.append(modifiedText)
            }
            if searchIngredients.isEmpty {
                searchIngredients = textFieldText
            } else {
                searchIngredients += ", \(textFieldText)"
            }
            ingredientsArrayUpdater?(ingredientsArray)
            searchIngredientsUpdater?(searchIngredients)
        } else {
            // TODO: - Add Alert
            print("already exists")
        }
    }
    
    func updateComponent(component: String) {
        var temporary = component
        temporary.capitalizeFirstLetter()
        addIngredient(with: createSearchIngredientsFrom(text: &temporary))
        ingredientsArrayUpdater?(ingredientsArray)
    }
    
    private func createSearchIngredientsFrom(text: inout String) -> String {
        text = text.replacingOccurrences(of: "-", with: " ")
        while let rangeToReplace = text.range(of: "\n") {
            text.replaceSubrange(rangeToReplace, with: ",")
        }
        text = text.trim()
        return text
    }
   
    func fetchProducts(with code: String) {
        network.fetchProducts(with: code) { result in
            switch result {
            case .success(let response):
                
                guard let safeResponse = response else {return}
                self.componentsArray = safeResponse.products[0].categoriesTags
                
                var newArray: [String] = []
                for component in self.componentsArray.enumerated() {
                    var element = component.element
                    element.removeFirst(3)
                    newArray.append(element)
                }
                self.componentsArray = newArray
                
                self.didShowHidePickerView?()
                self.didPickerViewReloadAllComponents?()
            case .failure(let error):
                self.didPresentAlert?(error)
            }
        }
    }
    
}
