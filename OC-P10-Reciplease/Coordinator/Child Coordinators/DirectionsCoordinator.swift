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
    
    deinit {
        print("DirectionsC deinit")
    }
    
    // MARK: - Navigation Management
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController)  else {
            return
        }
        
        if let directionsVC = fromViewController as? DirectionsViewController {
            directionsVC.viewModel.recipeCellViewModel = nil
            print("directionsVC.viewModel.recipeCellViewModel = nil")
            directionsVC.viewModel = nil
            didFinish?(self)
            navigationController.delegate = parentCoordinator
        }
    }
}

extension DirectionsCoordinator {
    private func showDirectionsScreen() {
        let viewModel = DirectionsViewModel(recipeCellViewModel: recipeCellViewModel)
        let viewController = DirectionsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
