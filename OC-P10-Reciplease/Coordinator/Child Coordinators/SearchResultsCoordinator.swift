//
//  SearchResultsCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchResultsCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: NavigationController
    private var ingredients: String
    
    init(navigationController: NavigationController, ingredients: String) {
        self.navigationController = navigationController
        self.ingredients = ingredients
        super.init()
    }
    
    override func start() {
        navigationController.delegate = self
        showSearchResultsScreen()
    }
}

extension SearchResultsCoordinator {
    
    private func showSearchResultsScreen() {
        let network = RecipeNetwork()
        let viewModel = SearchResultsViewModel(network: network, ingredients: ingredients)
        let viewController = SearchResultsViewController(viewModel: viewModel)
        
        viewController.didGetDetails = { [weak self] cell in
            self?.getDetails(cell: cell)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func getDetails(cell: RecipeCellViewModel) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, cell: cell)
        detailsCoordinator.parentCoordinator = self
        pushCoordinator(detailsCoordinator)
    }
}
