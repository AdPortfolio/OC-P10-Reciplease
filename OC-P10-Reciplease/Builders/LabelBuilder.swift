//
//  LabelBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class LabelBuilder {
    
    private var backgroundColor: UIColor = .clear
    private var textColor: UIColor = .label
    private var textAlignement: NSTextAlignment = .natural
    private var font = UIFont()
    private var accessibilityLabel =  String()
    private var maxContentSizeCat: UIContentSizeCategory = .extraExtraLarge
    private var numberOfLines: Int = 1
    
    private let imageAttachment = NSTextAttachment()
    private let mutableAttributedString = NSMutableAttributedString(string: "XX")
    private var attributedText = NSAttributedString()
    
    private var alpha : CGFloat = 1
    
    func setAttributedTextWithImageAttachment(imageName: String, imageTintColor: UIColor) -> LabelBuilder {
        imageAttachment.image = UIImage(systemName: imageName)?.withTintColor(imageTintColor)
            
        mutableAttributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedText = mutableAttributedString
        return self
    }
    
    func setBackgroundColor(with color: UIColor) -> LabelBuilder {
        self.backgroundColor = color
        return self
    }
    
    func setTextColor(with color: UIColor) -> LabelBuilder {
        self.textColor = color
        return self
    }
    
    func setTextAlignment(to alignement: NSTextAlignment) -> LabelBuilder {
        self.textAlignement = alignement
        return self
    }
    
    func setFont(to fontName: String, with fontSize: CGFloat, and textStyle: UIFont.TextStyle) -> LabelBuilder {
        guard let customFont = UIFont(name: fontName, size: fontSize) else {
            fatalError("Failed to load the Custom Font.")
        }
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        return self
    }
    
    func setAccessibilityLabel(as label: String) -> LabelBuilder {
        self.accessibilityLabel = label
        return self
    }
    
    func setMaxContentSizeCategory(as category: UIContentSizeCategory) -> LabelBuilder {
        self.maxContentSizeCat = category
        return self
    }
    
    func setNumberOfLines(_ number: Int) -> LabelBuilder {
        self.numberOfLines = number
        return self
    }
    

    
    func setAlpha(with value: CGFloat) -> LabelBuilder  {
        self.alpha = value
        return self
    }
    
    func build() -> UILabel {
        let label = UILabel()
        label.backgroundColor = backgroundColor
        label.textAlignment = textAlignement
        label.accessibilityLabel = accessibilityLabel
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        label.accessibilityLabel = accessibilityLabel
        label.maximumContentSizeCategory = maxContentSizeCat
        label.numberOfLines = numberOfLines
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
       
  
        return label
    }
}
