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
        }
    }
}
