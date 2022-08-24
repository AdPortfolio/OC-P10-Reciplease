//
//  SearchViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

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
    var didShowAnimation: (() -> Void)?
        
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

extension SearchViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ingredientsArray.count == 0 {
            didShowAnimation?()
        }
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ingredientsArray[indexPath.row]
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        guard let font = UIFont(name:"Chalkduster", size: 20) else {
            return UITableViewCell()
        }
        let fontMetrics = UIFontMetrics(forTextStyle: .title1)
        cell.textLabel?.font = fontMetrics.scaledFont(for: font)
        cell.maximumContentSizeCategory = .extraExtraLarge

        return cell
    }
}

extension SearchViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] _,_,_  in
            var word = ingredientsArray[indexPath.row]
            removeTwoCharacters(from: &word)
            if let range = searchIngredients.range(of: word) {
                searchIngredients.removeSubrange(range)
             
            }
            ingredientsArray.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
        deleteAction.image = UIImage(systemName: "xmark.circle")
        
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    private func removeTwoCharacters(from text: inout String) {
        text.removeFirst()
        text.removeFirst()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .systemGray5
        cell.textLabel?.textColor = .secondaryLabel
    }
}
