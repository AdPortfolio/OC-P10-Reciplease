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
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        navigationController.delegate = self
        showFavoritesScreen()
    }
}

extension FavoritesCoordinator {
    private func showFavoritesScreen() {
        let favoritesViewController = FavoritesViewController()
        
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
}
