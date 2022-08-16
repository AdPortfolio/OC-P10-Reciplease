//
//  StackViewBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class StackViewBuilder {
    
    private var backgroundColor: UIColor = .clear
    private var axis: NSLayoutConstraint.Axis = .horizontal
    private var distribution: UIStackView.Distribution = .fillEqually
    
    func setBackgroundColor(color: UIColor) -> StackViewBuilder {
        self.backgroundColor = color
        return self
    }
    
    func setAxis(axis: NSLayoutConstraint.Axis) -> StackViewBuilder {
        self.axis = axis
       return self
    }
    
    func setDistribution(distribution: UIStackView.Distribution) -> StackViewBuilder {
        self.distribution = distribution
        return self
    }
    
    func build() -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.backgroundColor = backgroundColor
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
