//
//  FavoritesViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import CoreData
import Lottie

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

    private let favLottieView:  AnimationView = {
        let animation = AnimationView()
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    private let lottieLabel = LabelBuilder()
        .setBackgroundColor(with: .clear)
        .setTextAlignment(to: .center)
        .setFont(to: "Chalkduster", with: 20, and: .body)
        .setTextColor(with: .systemGray)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(1)
        .build()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
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
    var recipes: Recipes?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        addLottieAnim()
        initViewModel()
    }
    
    deinit {
    //    print("Fav VC deinit")
    }
    
    @objc func initViewModel() {
        resultsTableView.refreshControl?.endRefreshing()
        
        viewModel.getRecipes()
        self.resultsTableView.reloadData()
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
    
    func addLottieAnim() {
            let path = Bundle.main.path(forResource: "favoritesAnim", ofType: "json") ?? ""
        favLottieView.backgroundColor = .clear
        favLottieView.animation = Animation.filepath(path)
      
        favLottieView.animationSpeed = 0.3
        favLottieView.play()
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
        
        viewModel.didInitViewModel = {
            self.initViewModel()
        }
        
        viewModel.didShowAnimation = {
            self.favLottieView.isHidden = false
            self.favLottieView.play()
            self.lottieLabel.isHidden = false
        }
        
        viewModel.didHideAnimation = {
            self.favLottieView.isHidden = true
            self.lottieLabel.isHidden = true
        }
        
        viewModel.lottieLabelUpdater = { text in
            self.lottieLabel.text = text
        }
        
        viewModel.didSendAlert = { (message, title) in
            self.alert(message: message, title: title)
        }
    }
}

//MARK: - User Interface Configuration
extension FavoritesViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultsTableView.bringSubviewToFront(favLottieView)
    }
    
    private func setupUI() {
        view.addSubview(resultsTableView)
        resultsTableView.addSubview(favLottieView)
        resultsTableView.addSubview(lottieLabel)
        
        navigationItem.rightBarButtonItem = deleteAllRecipesButton
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Chalkduster", size: 20)!, .foregroundColor: UIColor.white]
        
        deleteAllRecipesButton.accessibilityLabel = "Supprimer toutes les recettes Favorites"
        resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        favLottieView.centerXAnchor.constraint(equalTo: resultsTableView.centerXAnchor).isActive = true
        favLottieView.centerYAnchor.constraint(equalTo: resultsTableView.centerYAnchor).isActive = true
        favLottieView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        favLottieView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        lottieLabel.topAnchor.constraint(equalTo: favLottieView.bottomAnchor, constant: 8).isActive = true
        lottieLabel.centerXAnchor.constraint(equalTo: favLottieView.centerXAnchor).isActive = true
    }
}
