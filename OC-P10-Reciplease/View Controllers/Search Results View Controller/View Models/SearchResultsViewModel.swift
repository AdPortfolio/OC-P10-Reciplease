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
    var reloadTableView: (() -> Void)?
    var didGetDetails: ((RecipeCellViewModel) -> Void)?
    
    var recipeCellViewModels = [RecipeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    // MARK: - Inputs
    func viewDidLoad() {
        titleText?("Reciplease")
        backButtonItemTitleUpdater?("Back")
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModel {
        return recipeCellViewModels[indexPath.row]
    }
}

extension SearchResultsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to Dequeue Photo Table View Cell")
        }
        let cellVM = getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension SearchResultsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let cellVM = getCellViewModel(at: indexPath)
        didGetDetails?(cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
