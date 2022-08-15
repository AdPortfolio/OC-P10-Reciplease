//
//  AppCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let tabBarController = UITabBarController()
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    let searchCoordinator = SearchCoordinator()
    let favoritesCoodinator = FavoritesCoordinator(recipes: [])
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showFavoritesScreen), name: Notification.Name("FavoritesQA"), object: nil)
        
        tabBarController.viewControllers = [searchCoordinator.rootViewController, favoritesCoodinator.rootViewController]
        
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favoritesCoodinator)
    }
    
    // MARK: - Methods
    override func start() {
        searchCoordinator.start()
        favoritesCoodinator.start()
    }
    
    @objc private func showFavoritesScreen() {
        tabBarController.selectedIndex = 1
    }
}
