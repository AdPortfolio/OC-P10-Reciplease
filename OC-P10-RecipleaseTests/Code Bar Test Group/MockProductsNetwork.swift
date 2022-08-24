//
//  MockProductsNetwork.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 24/08/2022.
//

import Foundation
@testable import OC_P10_Reciplease

class MockProductsNetwork {
    
    let products: [Product]
    var productsResponse: ProductsResponse?
    
    init(products: [Product]) {
        self.products = products
        self.productsResponse = ProductsResponse(products: products)
    }
}

extension MockProductsNetwork: ProductsNetworkType {
   
    func fetchProducts(with barCode: String, completion: @escaping (Result<ProductsResponse?, Error>) -> ()) {
        guard self.productsResponse != nil else {
            completion(.failure(ServiceError.noDataReceived))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let data = try Data.codeBarFromJSON(fileName: "FakeCodeBarData")
            let products = try decoder.decode(ProductsResponse.self, from: data)
            completion(.success(products))
        } catch _ {
            completion(.failure(ServiceError.barCodeError))
        }
    }
}
