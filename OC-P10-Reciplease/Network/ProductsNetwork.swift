//
//  ProductsNetwork.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import Foundation
import Alamofire

final class ProductsNetwork: ProductsNetworkType {
    
    private let apiAdress = "https://world.openfoodfacts.org/api/v2/search?code="
    private var code = ""
    
    private func constructNameApiCall(with code: String) -> String {
        apiAdress + code
    }
    
    func fetchProducts(with barCode: String, completion: @escaping (Result<ProductsResponse?, Error>) -> ()) {
        let stringURL = constructNameApiCall(with: barCode)
      
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: ProductsResponse.self) { (response) in
                
                guard let products = response.value else {return}
                completion(.success(products))
            }
    }
}
