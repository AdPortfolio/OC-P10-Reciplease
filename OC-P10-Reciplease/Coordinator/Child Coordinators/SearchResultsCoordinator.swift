//
//  SearchResultsCoordinator.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchResultsCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: NavigationController
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        super.init()
    }
}