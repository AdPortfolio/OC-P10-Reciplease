//
//  SearchViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: SearchViewModel
    
    private var searchIngredients: String = ""
    private var ingredientsArray = [String]()
    private  let vegetables = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥬","🥒","🌶","🫑","🌽","🥕","🫒","🧄","🧅","🥔","🍠","🥩","🍗","🥚","🧀"]
    
    // MARK: - Closures
    var didSearchResults: ((String) -> Void)?
    
    // MARK: - User Interface Properties
    // Views
    private let containerView = ViewBuilder()
        .setBackgroundColor(with: .systemGray5)
        .build()
    
    private let line = ViewBuilder()
        .setBackgroundColor(with: .lightGray)
        .build()
    
    // Stack Views
    private let verticalStackView = StackViewBuilder()
        .setBackgroundColor(color: .clear)
        .setAxis(axis: .vertical)
        .setDistribution(distribution: .fill)
        .build()
    
    private let upperHorizontalStackView = StackViewBuilder()
        .setBackgroundColor(color: .clear)
        .setAxis(axis: .horizontal)
        .setDistribution(distribution: .fillEqually)
        .build()
    
    private let downerHorizontalStackView = StackViewBuilder()
        .setBackgroundColor(color: .clear)
        .setAxis(axis: .horizontal)
        .setDistribution(distribution: .fill)
        .build()
    
    // Labels
    private let fridgeLabel = LabelBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setTextAlignment(to: .center)
        .setFont(to: "PingFangHK-Light", with: 25, and: .body)
        .setTextColor(with: .systemGreen)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(0)
        .build()
    
    private let ingredientsLabel = LabelBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setTextAlignment(to: .natural)
        .setAccessibilityLabel(as: "Ingrédients")
        .setFont(to: "Chalkduster", with: 20, and: .body)
        .setTextColor(with: .label)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(1)
        .build()
    
    // Text Field
    private let ingredientsTextField = TextFieldBuilder()
        .setPlaceHolderString(placeholderString: "Lemon, Cheese, Sausages...", placeholderForegroundColor: .tertiaryLabel, placeholderFont: .boldSystemFont(ofSize: 17))
        .setFont(textStyle: .headline, scaledFont: .systemFont(ofSize: 17))
        .build()
    
    // Table View
    private let ingredientsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
        .addRefreshControl(false)
        .registerCell(cellClass: UITableViewCell.self, and: "Cell")
        .build()
    
    // Buttons
    private let addButton = ButtonBuilder()
        .setBackgroundColor(color: .systemGreen)
        .setTintColor(color: .white)
        .setAccessibilityLabel(text: "Ajouter à la liste")
        .setCordnerRadius(value: 5)
        .setTitleLabelFont(to: "ArialMT", with: 17, and: .body)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    private let clearButton = ButtonBuilder()
        .setBackgroundColor(color: .systemGray2)
        .setTintColor(color: .label)
        .setAccessibilityLabel(text: "Effacer toute la liste")
        .setCordnerRadius(value: 5)
        .setTitleLabelFont(to: "ArialMT", with: 17, and: .body)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    private let searchButton = ButtonBuilder()
        .setBackgroundColor(color: .systemGreen)
        .setTintColor(color: .label)
        .setAccessibilityLabel(text: "Ajouter à la liste")
        .setCordnerRadius(value: 5)
        .setTitleLabelFont(to: "Avenir-Light", with: 27, and: .body)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    // MARK: - View Controller Life Cycle
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ingredientsTableView.reloadData()
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearList), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchRecipe), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = viewModel
        ingredientsTableView.delegate = viewModel
        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions Methods
    @objc private func addIngredient() {
        guard let textFieldText = ingredientsTextField.text, !textFieldText.isEmpty else {return}
        viewModel.addIngredient(with: textFieldText)
        ingredientsTextField.text?.removeAll()
        ingredientsTableView.reloadData()
    }
    
    @objc private func clearList() {
        viewModel.clearIngredients()
        ingredientsTableView.reloadData()
    }
    
    @objc private func searchRecipe() {
        guard ingredientsArray.count > 0 else {
            alert(message: "Please enter at least one ingredient \(vegetables.randomElement() ?? "🧄")", title: "Ouch..")
            return
        }
        searchIngredients = createSearchIngredientsFrom(text: &searchIngredients)
        didSearchResults?(searchIngredients)
    }
    
    // MARK: Helpers
    private func createSearchIngredientsFrom(text: inout String) -> String {
        text = text.replacingOccurrences(of: "-", with: "")
        while let rangeToReplace = text.range(of: "\n") {
            text.replaceSubrange(rangeToReplace, with: ",")
        }
        text = text.trim()
        return text
    }
}

//MARK: - View Model Binding
extension SearchViewController {
    private func bind(to: SearchViewModel){
        viewModel.titleText = { text in
            self.title = text
        }
        
        viewModel.backButtonItemTitleUpdater = { title in
            self.navigationItem.backButtonTitle = title
        }
        
        viewModel.fridgeLabelUpdater = { labelText in
            self.fridgeLabel.text = labelText
        }
        
        viewModel.addButtonUpdater = { title in
            self.addButton.setTitle(title, for: .normal)
        }
        
        viewModel.clearButtonUpdater = { title in
            self.clearButton.setTitle(title, for: .normal)
        }
        
        viewModel.searchLabelUpdater = { searchLabelText in
            self.searchButton.setTitle(searchLabelText, for: .normal)
        }
        
        viewModel.ingredientsArrayUpdater = { ingredientsArray in
            self.ingredientsArray = ingredientsArray
        }
        
        viewModel.searchIngredientsUpdater = { searchIngredients in
            self.searchIngredients = searchIngredients
        }
        
        viewModel.ingredientsLabelUpdater = { text in
            self.ingredientsLabel.text = text
        }
    }
}

//MARK: - User Interface Configuration
extension SearchViewController {
    private func setupUI() {
       
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let tab = UITabBarItem(title: "Search", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        tabBarItem = tab
        
        view.addSubview(containerView)
        containerView.addSubview(fridgeLabel)
        containerView.addSubview(ingredientsTextField)
        containerView.addSubview(addButton)
        containerView.addSubview(line)
        
        view.addSubview(ingredientsLabel)
        view.addSubview(clearButton)
        view.addSubview(ingredientsTableView)
        view.addSubview(searchButton)
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        fridgeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        fridgeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        ingredientsTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        ingredientsTextField.topAnchor.constraint(equalTo: fridgeLabel.bottomAnchor, constant: 25).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor).isActive = true
        ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -3).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        line.leadingAnchor.constraint(equalTo: ingredientsTextField.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: ingredientsTextField.trailingAnchor).isActive = true
        line.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: 5).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        ingredientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16).isActive = true
        
        clearButton.centerYAnchor.constraint(equalTo: ingredientsLabel.centerYAnchor).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: addButton.trailingAnchor).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: addButton.leadingAnchor).isActive = true
        
        ingredientsTableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16).isActive = true
        ingredientsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        ingredientsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        ingredientsTableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor).isActive = true
        
        searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}
