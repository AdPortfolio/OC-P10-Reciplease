//
//  Coordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {
    
    // MARK: - Properties
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var didFinish: ((Coordinator) -> Void)?

    // MARK: - Methods
    func start() {}
    
    // MARK: - Navigation Management
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){}
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool){}
    
    // MARK: - Coordinators Management
    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        childCoordinators.append(coordinator)
        parentCoordinator = self
        coordinator.start()
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        for coordinator in childCoordinators {
            if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
                childCoordinators.remove(at: index)
           }
        }
    }
}
