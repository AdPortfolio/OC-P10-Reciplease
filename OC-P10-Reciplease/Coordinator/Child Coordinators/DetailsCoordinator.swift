//
//  DetailsCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import WebKit

final class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController:  NavigationController
    private var recipeCellViewModel: RecipeCellViewModel
    
    init(navigationController: NavigationController, cell: RecipeCellViewModel) {
        self.navigationController = navigationController
        self.recipeCellViewModel = cell
        super.init()
    }
    
    override func start() {
        navigationController.delegate = self
        showDetailsScreen()
    }

    // MARK: - Navigation Management
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController)  else {
            return
        }
        
        if let detailsVC = fromViewController as? DetailsViewController {
            detailsVC.viewModel.recipeCellViewModel = nil
        //    print("detailsVC.viewModel.recipeCellViewModel = nil")
            detailsVC.viewModel = nil
            didFinish?(self)
            navigationController.delegate = parentCoordinator
        }
    }
}

extension DetailsCoordinator {
    private func showDetailsScreen() {
        let viewModel = DetailsViewModel(recipeCellViewModel: recipeCellViewModel)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        viewController.didGetDirection = { [weak self] in
            self?.getDirections()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func getNewRecipe(recipes: [Recipe]) {
        let favoritesCoordinator = FavoritesCoordinator(recipes: recipes)
        pushCoordinator(favoritesCoordinator)
    }
    
    private func getDirections() {
        let directionsCoordinator = DirectionsCoordinator(navigationController: navigationController, recipeCellViewModel: recipeCellViewModel)
        directionsCoordinator.parentCoordinator = self
        pushCoordinator(directionsCoordinator)
    }
}
