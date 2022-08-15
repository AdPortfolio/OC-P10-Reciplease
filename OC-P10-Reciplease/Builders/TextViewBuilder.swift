//
//  TextViewBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import UIKit

final class TextViewBuilder {
    
    private var backgroundColor: UIColor = .clear
    private var textColor: UIColor = .systemBackground
    private var text = String()
    private var isEditable: Bool = true
    private var font = UIFont()
    private var maximumContentSizeCategory: UIContentSizeCategory = .extraExtraLarge
    
    func setBackgroundColor(with color: UIColor) -> TextViewBuilder {
        self.backgroundColor = color
        return self
    }
    
    func setTextColor(with color: UIColor) -> TextViewBuilder {
        self.textColor = color
        return self
    }
    
    func setText(text: String) -> TextViewBuilder {
        self.text = text
        return self
    }
    
    func setIsEditable(bool: Bool) -> TextViewBuilder {
        self.isEditable = bool
        return self
    }
    
    func setFont(to fontName: String, with fontSize: CGFloat, and textStyle: UIFont.TextStyle) -> TextViewBuilder {
        guard let customFont = UIFont(name: fontName, size: fontSize) else {
            fatalError("Failed to load the Custom Font.")
        }
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        return self
    }
    
    func setMaximumContentSizeCategory(category: UIContentSizeCategory) -> TextViewBuilder {
        self.maximumContentSizeCategory = category
        return self
    }
    
    func build() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.textColor = textColor
        textView.text = text
        textView.isEditable = isEditable
        textView.font = font
        textView.maximumContentSizeCategory = maximumContentSizeCategory
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
}
