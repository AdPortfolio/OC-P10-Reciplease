//
//  FavoritesViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FavoritesViewModel
    
    private let resultsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
        .registerCell(cellClass: UITableViewCell.self, and: "CellFav")
        .build()
    
    // MARK: - View Controller Life Cycle
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        resultsTableView.delegate = viewModel
        resultsTableView.dataSource = viewModel
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

//MARK: - View Model Binding
extension FavoritesViewController {
    private func bind(to: FavoritesViewModel){
        viewModel.titleText = { text in
            self.title = text
        }
    }
}

//MARK: - User Interface Configuration
extension FavoritesViewController {
    private func setupUI() {
        view.addSubview(resultsTableView)
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Chalkduster", size: 20)!, .foregroundColor: UIColor.white]
        
        resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
