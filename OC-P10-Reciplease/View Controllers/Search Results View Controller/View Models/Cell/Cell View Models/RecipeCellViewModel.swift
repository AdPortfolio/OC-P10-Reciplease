//
//  RecipeCellViewModel.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import Foundation

// MARK: - Recipe
struct RecipeCellViewModel: Equatable {
    let label: String
    let image: String
    let url: String
    let yield: Float
    let ingredientLines: [String]
    let totalTime: Float
    var favorites: Bool
    
    var stringedTotalTime: String {
        return String(totalTime)
    }
    
    var stringedYield: String {
        let integered = Int(yield)
        return String(integered)
    }
}
