//
//  ProductsNetworkType.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import Foundation

protocol ProductsNetworkType {
    func fetchProducts(with barCode: String, completion: @escaping (Result<ProductsResponse?, Error>) -> ())
}

