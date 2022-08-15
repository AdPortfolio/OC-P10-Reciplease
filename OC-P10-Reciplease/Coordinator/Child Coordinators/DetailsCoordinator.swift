//
//  DetailsCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

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
    
    private func getDirections() {
        let directionsCoordinator = DirectionsCoordinator(navigationController: navigationController, recipeCellViewModel: recipeCellViewModel)
        directionsCoordinator.parentCoordinator = self
        pushCoordinator(directionsCoordinator)
    }
}
