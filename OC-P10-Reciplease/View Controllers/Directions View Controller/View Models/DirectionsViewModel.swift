//
//  DirectionsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import UIKit

final class DirectionsViewModel: ObservableObject {
    
    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    
    var backButtonItemTitleUpdater: ((String) -> Void)?
    var recipeCellViewModel: RecipeCellViewModel!
    
    init(recipeCellViewModel: RecipeCellViewModel) {
        self.recipeCellViewModel = recipeCellViewModel
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
    }
    
    deinit {
        print("DirectionVM deinit")
    }
}
