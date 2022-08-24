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
    private var product: [String] = []
    private var component: String?
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override init() {
        super.init()
    }
    
    override func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showScanScreen), name: Notification.Name("ScanQA"), object: nil)
        navigationController.delegate = self
        navigationController.navigationBar.tintColor = .label
        showSearchScreen()
    }
    
    // MARK: - Navigation Management
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController)  else {
            return
        }
        
        if let _ = fromViewController as? SearchViewController {
            navigationController.delegate = parentCoordinator
            didFinish?(self)
        }
    }
}

extension SearchCoordinator {
    private func showSearchScreen() {
        let network = ProductsNetwork()
        let viewModel = SearchViewModel(network: network)
        let searchViewController = SearchViewController(viewModel: viewModel)
        
        searchViewController.didSearchResults = { [weak self] ingredients in
            self?.searchForRecipes(with: ingredients)
        }

        let cameraViewController = CameraViewController(viewModel: viewModel)
        
        let cameraNavigationController = NavigationController()
        cameraNavigationController.viewControllers = [cameraViewController]
        cameraNavigationController.modalPresentationStyle = .fullScreen
        
        searchViewController.didLaunchCamera = { [weak self] in
            self?.launchCamera(vc: cameraNavigationController)
        }
        
        cameraViewController.didGetProduct = { [weak self] product in
            self?.product = product
        }
        
        cameraViewController.didGetComponent = { [weak self] component in
            self?.component = component
        }
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    private func searchForRecipes(with ingredients: String) {
        let searchResultsCoordinator = SearchResultsCoordinator(navigationController: navigationController, ingredients: ingredients)
        searchResultsCoordinator.parentCoordinator = self
        pushCoordinator(searchResultsCoordinator)
    }
    
    private func launchCamera(vc: UIViewController) {
        navigationController.present(vc, animated: true)
    }
    
    @objc private func showScanScreen() {
        let network = ProductsNetwork()
        let viewModel = SearchViewModel(network: network)
        let cameraViewController = CameraViewController(viewModel: viewModel)
        
        let cameraNavigationController = NavigationController()
        cameraNavigationController.viewControllers = [cameraViewController]
        cameraNavigationController.modalPresentationStyle = .fullScreen
        
        navigationController.present(cameraNavigationController, animated: true)
    }
}
