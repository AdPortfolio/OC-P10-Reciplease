//
//  SearchViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
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
    
    let ingredientsLabel = LabelBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setTextAlignment(to: .natural)
        .setAccessibilityLabel(as: "Ingrédients")
        .setFont(to: "Chalkduster", with: 20, and: .body)
        .setTextColor(with: .label)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(1)
        .build()
    
    // Text Field
    let ingredientsTextField = TextFieldBuilder()
        .setPlaceHolderString(placeholderString: "Lemon, Cheese, Sausages...", placeholderForegroundColor: .tertiaryLabel, placeholderFont: .boldSystemFont(ofSize: 17))
        .setFont(textStyle: .headline, scaledFont: .systemFont(ofSize: 17))
        .build()
    
    // Table View
    let ingredientsTableView = TableViewBuilder()
        .setBackgroundColor(color: .systemGray5)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - User Interface Configuration
extension SearchViewController {
    private func setupUI() {
        let tab = UITabBarItem(title: "Search", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        tabBarItem = tab
    }
}
