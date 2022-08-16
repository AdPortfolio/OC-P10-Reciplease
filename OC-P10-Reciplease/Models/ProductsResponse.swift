//
//  ProductsResponse.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import Foundation

typealias Products = [Product]

struct ProductsResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let categoriesTags: [String]
    let productName: String
    
    enum CodingKeys: String, CodingKey {
        case categoriesTags = "categories_tags"
        case productName = "product_name"
    }
}

extension Product: Equatable {}

extension ProductsResponse: Equatable {
    static func == (lhs: ProductsResponse, rhs: ProductsResponse) -> Bool {
        var bool = false
       
        if lhs.products == rhs.products {
            bool = true
        }
        return bool
    }
}
