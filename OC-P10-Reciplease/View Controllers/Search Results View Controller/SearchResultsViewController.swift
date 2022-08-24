//
//  SearchResultsViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import Alamofire

final class SearchResultsViewController: UIViewController {
   
    // MARK: - Properties
    var viewModel: SearchResultsViewModel!
    
    // MARK: - Closures
    var didGetDetails: ((RecipeCellViewModel) -> Void)?

    // MARK: - User Interface Properties
    private let resultsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
        .registerCell(cellClass: CustomTableViewCell.self, and: CustomTableViewCell.identifier)
        .build()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - View Controller Life Cycle
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
        initViewModel(ingredients: viewModel.ingredients)
    }
    
    private func initViewModel(ingredients: String) {
        viewModel.getRecipes(with: ingredients)
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.resultsTableView.reloadData()
            }
        }
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
        
        viewModel.didGetDetails = { recipeVM in
            self.didGetDetails?(recipeVM)
        }
    }
}

// MARK: - Table View Data Source & Delegate
extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipeCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to Dequeue Photo Table View Cell")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        didGetDetails?(cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

// MARK: - User Interface Setup
extension SearchResultsViewController {
    private func setupUI() {
        view.addSubview(resultsTableView)
        view.backgroundColor = .systemGray5
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
