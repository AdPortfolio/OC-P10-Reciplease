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

extension SearchResultsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

extension SearchResultsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
