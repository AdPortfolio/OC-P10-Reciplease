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
        let viewController = SearchResultsViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
