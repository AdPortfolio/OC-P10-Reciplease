//
//  ImageViewBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class ImageViewBuilder {
    
    private var contentMode: UIView.ContentMode = .scaleAspectFit
    private var alpha: CGFloat = 1
    private var tintColor: UIColor = .clear
    private var image = UIImage()
    
    func setContentMode(contentMode: UIView.ContentMode) -> ImageViewBuilder {
        self.contentMode = contentMode
        return self
    }
    
    func setAlpha(with value: CGFloat) -> ImageViewBuilder {
        self.alpha = value
        return self
    }
    
    func setTintColor(_ color: UIColor) -> ImageViewBuilder {
        self.tintColor = color
        return self
    }
    
    func setImageConfiguration(imageName: String, pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) -> ImageViewBuilder  {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        
        guard let image = UIImage(systemName: imageName, withConfiguration: configuration) else { return self }
        self.image = image
        return self
    }
    
    func setImage(name: String) -> ImageViewBuilder {
        guard let image = UIImage(named: name) else {
            return self
        }
        
        self.image = image
        return self
    }
    
    func build() -> UIImageView {
        let view = UIImageView()
        view.contentMode = contentMode
        view.alpha = alpha
        view.tintColor = tintColor
        view.image = image
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
