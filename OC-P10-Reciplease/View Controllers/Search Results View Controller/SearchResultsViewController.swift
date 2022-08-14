//
//  SearchResultsViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: SearchResultsViewModel!
    
    // MARK: - User Interface Properties
    private let resultsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
        .registerCell(cellClass: UITableViewCell.self, and: "Cell")
        .build()
    
    // MARK: - View Controller Life Cycle
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
    }
}

//MARK: - View Model Binding
extension SearchResultsViewController {
    private func bind(to: SearchResultsViewModel) {
        viewModel.titleText = { title in
            self.title = title
        }
        
        viewModel.backButtonItemTitleUpdater = { title in
            self.navigationItem.backButtonTitle = title
        }
    }
}

// MARK: User Interface Setup
extension SearchResultsViewController {
    private func setupUI() {
        view.addSubview(resultsTableView)
        view.backgroundColor = .brown
        navigationItem.leftBarButtonItem?.tintColor = .label
        resultsTableView.dataSource = viewModel
        resultsTableView.delegate = viewModel
        
        resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

