//
//  CustomTableViewCell.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    static let identifier = "Recipe"
    
    var cellViewModel: RecipeCellViewModel? {
        didSet {
            
        }
    }
}
