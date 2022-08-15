//
//  DirectionsCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class DirectionsCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController:  NavigationController
    private var recipeCellViewModel: RecipeCellViewModel
    
    init(navigationController: NavigationController, recipeCellViewModel: RecipeCellViewModel) {
        self.navigationController = navigationController
        self.recipeCellViewModel = recipeCellViewModel
        super.init()
    }
    
    override func start() {
        navigationController.delegate = self
        showDirectionsScreen()
    }
}

extension DirectionsCoordinator {
    private func showDirectionsScreen() {
        let viewModel = DirectionsViewModel(recipeCellViewModel: recipeCellViewModel)
        let viewController = DirectionsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
