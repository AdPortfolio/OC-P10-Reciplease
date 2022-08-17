//
//  ServiceError.swift
//  OC-P10-RecipleaseTests
//
//  Created by Walim Aloui on 17/08/2022.
//

import Foundation

enum ServiceError: Swift.Error {
    case undefined
    case recipeError
    case barCodeError
    case noDataReceived
    var localizedDescription: String {
        switch self {
        case .undefined:
            return "An error occured"
        case .recipeError:
            return "An error occured please try again"
        case .barCodeError:
            return "An error occured please try again"
        case .noDataReceived:
            return "An error occured please try again"
          
        }
    }
}
