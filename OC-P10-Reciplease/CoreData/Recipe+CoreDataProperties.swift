//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Walim Aloui on 15/08/2022.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var favorites: Bool
    @NSManaged public var image: String
    @NSManaged public var ingredientLines: [String]
    @NSManaged public var label: String
    @NSManaged public var totalTime: Float
    @NSManaged public var url: String
    @NSManaged public var yield: Float

}
