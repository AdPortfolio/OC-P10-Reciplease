//
//  FavoritesViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import CoreData

final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FavoritesViewModel
    
    // MARK: - Closures
    var didGetDetails: ((RecipeCellViewModel) -> Void)?
    
    // MARK: - User Interface Properties
    lazy var deleteAllRecipesButton = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .done, target: self, action: #selector(clearDatabase))
    
    private let resultsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
        .registerCell(cellClass: CustomTableViewCell.self, and: CustomTableViewCell.identifier)
        .build()
    
    // MARK: - View Controller Life Cycle
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        resultsTableView.delegate = viewModel
        resultsTableView.dataSource = viewModel
        
        initViewModel()
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
    
    deinit {
        print("Fav VC deinit")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
    
    @objc func initViewModel() {
        resultsTableView.refreshControl?.endRefreshing()
        viewModel.getRecipes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.resultsTableView.refreshControl?.endRefreshing()
              self.resultsTableView.reloadData()
        }
    }
    
    @objc func clearDatabase() {
        if viewModel.recipes?.isEmpty == true {
            
        } else {
            let alert = UIAlertController(title: "Delete Favorites", message: "Are you sure to delete all your Favorites?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.clearDataBase()
                self.initViewModel()
            }
            deleteAction.accessibilityLabel = "Oui, Supprimer"
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            cancel.accessibilityLabel = "Non, ne pas Supprimer"
            
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.resultsTableView.reloadData()
            }
        }
    }
}

//MARK: - View Model Binding
extension FavoritesViewController {
    private func bind(to: FavoritesViewModel){
        viewModel.titleText = { text in
            self.title = text
        }
        
        viewModel.didGetDetails = { recipeVM in
            self.didGetDetails?(recipeVM)
        }
    }
}

//MARK: - User Interface Configuration
extension FavoritesViewController {
    private func setupUI() {
        view.addSubview(resultsTableView)
        navigationItem.rightBarButtonItem = deleteAllRecipesButton
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Chalkduster", size: 20)!, .foregroundColor: UIColor.white]
        
        deleteAllRecipesButton.accessibilityLabel = "Supprimer toutes les recettes Favorites"
        resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
