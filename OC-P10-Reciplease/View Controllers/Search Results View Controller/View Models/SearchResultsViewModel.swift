//
//  SearchResultsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchResultsViewModel: NSObject {
    
    var ingredients: String
    
    // MARK: - Closures
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    var didGetDetails: ((RecipeCellViewModel) -> Void)?
    
    var recipeCellViewModels = [RecipeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    // MARK: - Inputs
    init(ingredients: String) {
        self.ingredients = ingredients
    }
    
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModel {
        return recipeCellViewModels[indexPath.row]
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

extension SearchResultsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to Dequeue Photo Table View Cell")
        }
        let cellVM = getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension SearchResultsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let cellVM = getCellViewModel(at: indexPath)
        didGetDetails?(cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
