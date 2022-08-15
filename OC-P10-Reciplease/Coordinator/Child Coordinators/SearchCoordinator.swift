//
//  SearchCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController = NavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        navigationController.delegate = self
        showSearchScreen()
    }
}

extension SearchCoordinator {
    private func showSearchScreen() {
        let viewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: viewModel)
        
        searchViewController.didSearchResults = { [weak self] ingredients in
            self?.searchForRecipes(with: ingredients)
        }
        
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    private func searchForRecipes(with ingredients: String) {
        let searchResultsCoordinator = SearchResultsCoordinator(navigationController: navigationController, ingredients: ingredients)
        searchResultsCoordinator.parentCoordinator = self
        pushCoordinator(searchResultsCoordinator)
    }
}
