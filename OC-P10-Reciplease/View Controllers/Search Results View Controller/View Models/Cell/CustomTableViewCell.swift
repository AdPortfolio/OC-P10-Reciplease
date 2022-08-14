//
//  CustomTableViewCell.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    static let identifier = "Recipe"
    
    // MARK: - User Interface Properties
    private var mealImageView = ImageViewBuilder()
        .setContentMode(contentMode: .scaleAspectFill)
        .build()
    
    private let mealNameLabel = LabelBuilder()
        .setTextColor(with: .white)
        .setFont(to: "Papyrus", with: 20, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    private let ingredientsLabel = LabelBuilder()
        .setTextColor(with: .white)
        .setFont(to: "Avenir-Roman", with: 15, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    private let containerView = ViewBuilder()
        .setBackgroundColor(with: .systemGray5)
        .setCornerRadius(value: 5)
        .build()
    
    private let thumbsLabel = LabelBuilder()
        .setFont(to: "Avenir-Roman", with: 16, and: .title1)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .setTextColor(with: .label)
        .setTextAlignment(to: .right)
        .build()
    
    private let timeLabel = LabelBuilder()
        .setFont(to: "Avenir-Roman", with: 16, and: .title1)
        .setTextColor(with: .label)
        .setTextAlignment(to: .right)
        .setMaxContentSizeCategory(as: .extraExtraLarge)
        .build()
    
    var cellViewModel: RecipeCellViewModel? {
        didSet {
            mealNameLabel.text = cellViewModel?.label
            ingredientsLabel.text = cellViewModel?.ingredientLines[0]
            
            let watchImageAttachment = NSTextAttachment()
            watchImageAttachment.image = UIImage(systemName: "stopwatch")?.withTintColor(.label)
            
            let fullString = NSMutableAttributedString(string: cellViewModel!.stringedTotalTime)
            fullString.append(NSAttributedString(string: " "))
            fullString.append(NSAttributedString(attachment: watchImageAttachment))
            timeLabel.attributedText = fullString
            
            let thumbImageAttachment = NSTextAttachment()
            thumbImageAttachment.image = UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.label)
            let thumbFullString = NSMutableAttributedString(string: cellViewModel!.stringedYield)
            thumbFullString.append(NSAttributedString(string: " "))
            thumbFullString.append(NSAttributedString(attachment: thumbImageAttachment))
            thumbsLabel.attributedText = thumbFullString
            
            guard let imageString = cellViewModel?.image else {return}
            
            guard let url = URL(string: imageString) else {return}
            mealImageView.load(url: url)
        }
    }
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1.0)
        layer.colors = [
            UIColor.clear.cgColor,UIColor.black.cgColor]
        return layer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mealImageView)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(containerView)
        mealImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    deinit {
        cellViewModel = nil
        print("CustomTVCell deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        gradientLayer.frame = bounds
        contentView.layer.cornerRadius = bounds.maxY/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mealImageView.topAnchor.constraint(equalTo:contentView.topAnchor).isActive = true
        mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6).isActive = true
        
        mealNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mealNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        mealNameLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor).isActive = true
        
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        containerView.addSubview(thumbsLabel)
        thumbsLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        thumbsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        thumbsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.addSubview(timeLabel)
        timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientsLabel.text = nil
        mealNameLabel.text = nil
        mealImageView.image = nil
        thumbsLabel.text = nil
        timeLabel.text = nil
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
