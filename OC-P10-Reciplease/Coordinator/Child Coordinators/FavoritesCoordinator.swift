//
//  FavoritesCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController = NavigationController()
    var recipes: [Recipe]?
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    override func start() {
        navigationController.delegate = self
        navigationController.navigationBar.tintColor = .label
        showFavoritesScreen()
    }
}

extension FavoritesCoordinator {
    private func showFavoritesScreen() {
        guard let recipes = recipes else {return}
        let viewModel = FavoritesViewModel(recipes: recipes)
        
        let favoritesViewController = FavoritesViewController(viewModel: viewModel)
        
        favoritesViewController.didGetDetails = { [weak self] cell in
            self?.getDetails(cell: cell)
        }
        
        let tab = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        favoritesViewController.tabBarItem = tab
        
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    private func getDetails(cell: RecipeCellViewModel) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, cell: cell)
        detailsCoordinator.parentCoordinator = self
        pushCoordinator(detailsCoordinator)
    }
}
