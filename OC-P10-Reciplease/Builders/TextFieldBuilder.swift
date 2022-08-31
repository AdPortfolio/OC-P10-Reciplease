//
//  TextFieldBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class TextFieldBuilder {
    
    private var attributedPlaceholder =  NSAttributedString()
    private var font = UIFont()
    private var textColor = UIColor()
    private var accessibilityLabel = String()
    
    func setPlaceHolderString(placeholderString: String, placeholderForegroundColor: UIColor, placeholderFont: UIFont) -> TextFieldBuilder {
        self.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor : placeholderForegroundColor, .font: placeholderFont])
        return self
    }
    
    func setPlaceHolderFont(font: UIFont) -> TextFieldBuilder {
        return self
    }
    
    func setFont(textStyle: UIFont.TextStyle, scaledFont: UIFont) -> TextFieldBuilder {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: scaledFont)
        self.font = fontMetrics
        return self
    }
    
    func setTextColor(color: UIColor) -> TextFieldBuilder {
        self.textColor = color
        return self
    }
    
    func setAccessibilityLabel(as label: String) -> TextFieldBuilder {
        self.accessibilityLabel = label
        return self
    }
    
     func build() -> UITextField {
        let field = UITextField()
        field.attributedPlaceholder = attributedPlaceholder
        field.font = font
        field.adjustsFontForContentSizeCategory = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}
