//
//  ViewBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class ViewBuilder {
    
    private var backgroundColor: UIColor = .clear
    private var maximumContentSizeCategory: UIContentSizeCategory = .extraExtraLarge
    private var alpha: CGFloat = 1
    private var isHidden: Bool = false
    private var cornerRadius: CGFloat = 0
    
    func setBackgroundColor(with color: UIColor) -> ViewBuilder {
        self.backgroundColor = color
        return self
    }
    
    func setMaximumContentSizeCategory(category: UIContentSizeCategory) -> ViewBuilder {
        self.maximumContentSizeCategory = category
        return self
    }
    
    func setAlpha(value: CGFloat) -> ViewBuilder {
        self.alpha = value
        return self
    }
    
    func setIsHidden(bool: Bool) -> ViewBuilder {
        self.isHidden = bool
        return self
    }
    
    func setCornerRadius(value: CGFloat) -> ViewBuilder {
        self.cornerRadius = value
        return self
    }
    
    func build() -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.maximumContentSizeCategory = maximumContentSizeCategory
        view.alpha = alpha
        view.isHidden = isHidden
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
