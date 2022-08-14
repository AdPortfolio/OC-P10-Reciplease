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
    
    var rootViewController: UIViewController {
        return navigationController
    }
}
