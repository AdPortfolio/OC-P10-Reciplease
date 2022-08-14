//
//  SearchResultsViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchResultsViewModel: NSObject {
    
    // MARK: - Closures
    var titleText: ((String) -> Void)?
    var backButtonItemTitleUpdater: ((String) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
    }
}
