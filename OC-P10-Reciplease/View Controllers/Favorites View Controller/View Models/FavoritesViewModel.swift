//
//  FavoritesViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class FavoritesViewModel: NSObject {
    
    private let notificationName = "Favorites"

    // MARK: - Outputs
    var titleText: ((String) -> Void)?
    var reloadTableView: (() -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
    }
}

extension FavoritesViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension FavoritesViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
