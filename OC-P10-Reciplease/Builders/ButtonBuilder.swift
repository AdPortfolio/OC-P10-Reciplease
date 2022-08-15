//
//  ButtonBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class ButtonBuilder {
    
    private var backgroundColor: UIColor = .clear
    private var tintColor: UIColor = .clear
    private var accessibilityLabel = String()
    private var cornerRadius: CGFloat = 0
    private var title = String()
    private var font = UIFont()
    private var maxContentSizeCat: UIContentSizeCategory = .extraExtraLarge
    
    
    func setBackgroundColor(color: UIColor) -> ButtonBuilder {
        self.backgroundColor = color
        return self
    }
    
    func setTintColor(color: UIColor) -> ButtonBuilder {
        self.tintColor = color
        return self
    }
    
    func setAccessibilityLabel(text: String) -> ButtonBuilder {
        self.accessibilityLabel = text
        return self
    }
    
    func setCordnerRadius(value: CGFloat) -> ButtonBuilder {
        self.cornerRadius = value
        return self
    }
    
    func setTitle(text: String) -> ButtonBuilder {
        self.title = text
        return self
    }
    
    func setMaxContentSizeCategory(as category: UIContentSizeCategory) -> ButtonBuilder {
        self.maxContentSizeCat = category
        return self
    }
    
    func setTitleLabelFont(to fontName: String, with fontSize: CGFloat, and textStyle: UIFont.TextStyle) -> ButtonBuilder {
        guard let customFont = UIFont(name: fontName, size: fontSize) else {
            fatalError("Failed to load the Custom Font.")
        }
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        return self
    }
    
    func build() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.accessibilityLabel = accessibilityLabel
        button.layer.cornerRadius = cornerRadius
        button.titleLabel?.font = font
        button.tintColor = tintColor
        //  button.addTarget(self, action: selector, for: .touchUpInside)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
