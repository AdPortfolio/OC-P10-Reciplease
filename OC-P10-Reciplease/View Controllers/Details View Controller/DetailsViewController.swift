//
//  DetailsViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import CoreData

final class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailsViewModel!
    
    private var recipes = [Recipe]()
    
    // MARK: - Closures
    var didGetDirection: (() -> Void)?
    var didAddNewRecipe: (([Recipe]) -> Void)?
    
    private lazy var unfavoredButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(addToFavorites))
    private lazy var favoredButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action:  #selector(removeFromFavorites))
    
    // MARK: - User Interface Properties
    private let mealImageView = ImageViewBuilder()
        .setContentMode(contentMode: .scaleAspectFill)
        .build()
    
    private let mealNameLabel = LabelBuilder()
        .setBackgroundColor(with: .clear)
        .setTextAlignment(to: .center)
        .setFont(to: "PingFangHK-Regular", with: 25, and: .body)
        .setTextColor(with: .white)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(0)
        .build()
    
    private let ingredientsLabel = LabelBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setTextAlignment(to: .natural)
        .setFont(to: "Chalkduster", with: 20, and: .body)
        .setTextColor(with: .label)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setNumberOfLines(0)
        .build()
    
    private let getDirectionsButton = ButtonBuilder()
        .setBackgroundColor(color: .systemGreen)
        .setTintColor(color: .label)
        .setAccessibilityLabel(text: "Aller vers les instructions")
        .setCordnerRadius(value: 10)
        .setTitleLabelFont(to: "Avenir-Light", with: 25, and: .body)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()

    private let recipeTextView = TextViewBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setText(text: " - ")
        .setIsEditable(bool: false)
        .setFont(to: "Chalkduster", with: 16, and: .title1)
        .setMaximumContentSizeCategory(category: .extraExtraLarge)
        .setTextColor(with: .label)
        .build()

    private let containerView = ViewBuilder()
        .setBackgroundColor(with: .systemGray5)
        .build()

    private let thumbsLabel = LabelBuilder()
        .setAttributedTextWithImageAttachment(imageName: "hand.thumbsup.fill", imageTintColor: .white)
        .setFont(to: "AvenirNext-Medium", with: 20, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setTextColor(with: .label)
        .setTextAlignment(to: .right)
        .build()
    
    private let timeLabel = LabelBuilder()
        .setAttributedTextWithImageAttachment(imageName: "stopwatch", imageTintColor: .label)
        .setFont(to: "AvenirNext-Medium", with: 20, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setTextColor(with: .label)
        .setTextAlignment(to: .right)
        .build()
    
    private let isFavoredSymbol = ImageViewBuilder()
        .setImageConfiguration(imageName: "checkmark.circle.fill", pointSize: 40, weight: .bold, scale: .large)
        .setAlpha(with: 1)
        .setTintColor(.yellow)
        .build()
    
    private let informationView = ViewBuilder()
        .setBackgroundColor(with: .secondarySystemBackground)
        .setAlpha(value: 0.9)
        .setIsHidden(bool: true)
        .setCornerRadius(value: 8)
        .build()

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1.0)
        layer.colors = [
            UIColor.clear.cgColor, UIColor(red: 0.20, green: 0.53, blue: 0.30, alpha: 1.00)]
        return layer
    }()
    
    private let isFavoredLabel = LabelBuilder()
        .setTextAlignment(to: .center)
        .setNumberOfLines(0)
        .setAlpha(with: 1)
        .setFont(to: "Avenir-Roman", with: 18, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - View Controller Life Cycle
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        let recipeFetch: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        recipeFetch.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(recipeFetch)
            
            guard !results.isEmpty else {
                navigationItem.rightBarButtonItem = unfavoredButton
                return
            }
            for result in results {
                if result.label == viewModel.recipeCellViewModel.label  {
                    print("recipe exists")
                    
                    navigationItem.rightBarButtonItem = favoredButton
                    favoredButton.accessibilityLabel = "Inscrit dans les Favorites"
                    return
                } else {
                    navigationItem.rightBarButtonItem = unfavoredButton
                }
            }
        } catch {
            print("failed in finding context")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    deinit {
        print("DetailsVC deinit")
    }

    @objc private func getDirections() {
        didGetDirection?()
    }
    
    @objc private func addToFavorites(){
        // mise à jour du recipes du VM
        viewModel.recipes = recipes
        
        let recipeFetch: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        recipeFetch.sortDescriptors = [sortByName]
        // Chercher si une recette existe déjà
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(recipeFetch)
            for result in results {
                if result.label == viewModel.recipeCellViewModel.label  {
                    print("recipe exists")
                    navigationItem.rightBarButtonItem = favoredButton
                    return
                } 
            }
        } catch {
            print("failed in finding context")
        }
        
        // Blanchit l'étoile
        navigationItem.rightBarButtonItem = favoredButton
        
        viewModel.recipeCellViewModel.favorites = true
        
        let managedContext = PersistenceController.shared.container.viewContext
        let newRecipe = Recipe(context: managedContext)
        newRecipe.favorites = true
        newRecipe.setValue(viewModel.recipeCellViewModel.label, forKey: #keyPath(Recipe.label))
        newRecipe.setValue(viewModel.recipeCellViewModel.image, forKey: #keyPath(Recipe.image))
        newRecipe.setValue(viewModel.recipeCellViewModel.ingredientLines, forKey: #keyPath(Recipe.ingredientLines))
        newRecipe.setValue(viewModel.recipeCellViewModel.totalTime, forKey: #keyPath(Recipe.totalTime))
        newRecipe.setValue(viewModel.recipeCellViewModel.url, forKey: #keyPath(Recipe.url))
        newRecipe.setValue(viewModel.recipeCellViewModel.yield, forKey: #keyPath(Recipe.yield))
        newRecipe.setValue(viewModel.recipeCellViewModel.favorites, forKey: #keyPath(Recipe.favorites))
        
        viewModel.recipes.insert(newRecipe, at: 0)
        do {
            try managedContext.save()
        } catch {}
        
        var info = ["recipes":recipes]
        info["recipes"]?.append(contentsOf: recipes)
        NotificationCenter.default.post(name: Notification.Name("Favorites"), object: nil, userInfo: info)
        showAddedView()
    }
    
    @objc private func removeFromFavorites() {
        showRemovedView()
        navigationItem.rightBarButtonItem = unfavoredButton
        
        let recipeFetch: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        recipeFetch.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(recipeFetch)
            viewModel.recipes = results
            for (_, result) in results.enumerated() {
                if result.label == viewModel.recipeCellViewModel.label  {
                    print("recipe exists")
                    navigationItem.rightBarButtonItem = unfavoredButton
                    managedContext.delete(result)
                    
                    viewModel.recipes = results
                    
                    var info = ["recipes":recipes]
                    info["recipes"]?.append(contentsOf: recipes)
                    NotificationCenter.default.post(name: Notification.Name("Favorites"), object: nil, userInfo: info)
                    unfavoredButton.accessibilityLabel = "Inexistant dans les Favorites"
                    return
                } else {
                    print("recipe does not exist yet")
                }
            }
        } catch {
            print("failed in finding context")
        }
    }
    
    private func showAddedView() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .default)
        isFavoredSymbol.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)
        isFavoredSymbol.tintColor = .systemGreen
        
        isFavoredLabel.text = "Recipe saved to Favorites!"
        informationView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.informationView.isHidden = true
        }
    }
    
    private func showRemovedView() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .default)
        isFavoredSymbol.image = UIImage(systemName: "x.circle.fill", withConfiguration: largeConfig)
        isFavoredSymbol.tintColor = .systemRed
        
        isFavoredLabel.text = "Recipe removed from Favorites!"
        informationView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           self.informationView.isHidden = true
        }
    }
}

//MARK: - View Model Binding
extension DetailsViewController {
    private func bind(to: DetailsViewModel) {
        viewModel.titleText = { title in
            self.title = title
        }
        
        viewModel.backButtonItemTitleUpdater = { title in
            self.navigationItem.backButtonTitle = title
        }
        
        viewModel.mealLabelUpdater = { text in
            self.mealNameLabel.text = text
        }
        
        viewModel.ingredientsLabelUpdater = { text in
            self.ingredientsLabel.text = text
        }
        
        viewModel.recipeTextViewUpdater = { text in
            self.recipeTextView.text += text
        }
        
        viewModel.getDirectionsButtonUpdater = { title in
            self.getDirectionsButton.setTitle(title, for: .normal)
        }
        
        viewModel.imageUpdater = { imageName in
            let imageName = imageName
            let url = URL(string: imageName)
            guard let url = url else {return}
            self.mealImageView.load(url: url)
        }
        
        viewModel.yieldUpdater = { yield in
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.label)
            let fullString = NSMutableAttributedString(string: yield)
            fullString.append(NSAttributedString(attachment: imageAttachment))
            self.thumbsLabel.attributedText = fullString
        }
        
        viewModel.totalTimeUpdater = { totalTime in
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "stopwatch")?.withTintColor(.label)
            let fullString = NSMutableAttributedString(string: totalTime)
            fullString.append(NSAttributedString(attachment: imageAttachment))
            self.timeLabel.attributedText = fullString
        }
        
        viewModel.isFavoredLabelUpdater = { text in
            self.isFavoredLabel.text = text
        }
    }
}

//MARK: - User Interface Configuration
extension DetailsViewController {
    private func setupUI() {
        view.backgroundColor = .systemGray5
        unfavoredButton.tintColor = .label
        favoredButton.tintColor = .label
        
        view.addSubview(mealImageView)
        mealImageView.addSubview(mealNameLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(recipeTextView)
        view.addSubview(getDirectionsButton)
        view.addSubview(containerView)
        view.addSubview(informationView)
        
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        containerView.topAnchor.constraint(equalTo: mealImageView.topAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: -16).isActive = true
        
        containerView.addSubview(thumbsLabel)
        thumbsLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        thumbsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        thumbsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.addSubview(timeLabel)
        timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        mealImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mealImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mealImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mealImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        mealNameLabel.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor).isActive = true
        mealNameLabel.leadingAnchor.constraint(equalTo: mealImageView.leadingAnchor, constant: 3).isActive = true
        mealNameLabel.trailingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: -3).isActive = true
        mealNameLabel.bottomAnchor.constraint(equalTo: mealImageView.bottomAnchor).isActive = true
        
        ingredientsLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 8).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        recipeTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        recipeTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        recipeTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        recipeTextView.bottomAnchor.constraint(equalTo: getDirectionsButton.topAnchor, constant: -6).isActive = true

        getDirectionsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        getDirectionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        getDirectionsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        getDirectionsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        getDirectionsButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        gradientLayer.frame = view.bounds
        mealImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        informationView.addSubview(isFavoredLabel)
        informationView.addSubview(isFavoredSymbol)

        informationView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        informationView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true

        informationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45).isActive = true
        informationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45).isActive = true

        isFavoredLabel.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 8).isActive = true
        isFavoredLabel.centerXAnchor.constraint(equalTo: informationView.centerXAnchor).isActive = true
        isFavoredLabel.bottomAnchor.constraint(equalTo: isFavoredSymbol.topAnchor, constant: -16).isActive = true
        
        isFavoredSymbol.bottomAnchor.constraint(equalTo: informationView.bottomAnchor, constant: -8).isActive = true
        isFavoredSymbol.centerXAnchor.constraint(equalTo: informationView.centerXAnchor).isActive = true
    }
}
