//
//  DirectionsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import Foundation

final class DirectionsViewModel {

    // MARK: - Init
    init(recipeCellViewModel: RecipeCellViewModel) {
        self.recipeCellViewModel = recipeCellViewModel
    }

    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var recipeCellViewModel: RecipeCellViewModel!
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
    }
}
