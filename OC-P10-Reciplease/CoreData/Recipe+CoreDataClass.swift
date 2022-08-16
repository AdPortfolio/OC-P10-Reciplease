//
//  Recipe+CoreDataClass.swift
//  
//
//  Created by Walim Aloui on 16/08/2022.
//
//

import Foundation
import CoreData

public class Recipe: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case label, image, url, yield, ingredientLines, totalTime
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard CodingUserInfoKey.context != nil else { fatalError("cannot find context key") }
        
        let managedObjectContext =  AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: managedObjectContext) else { fatalError() }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.label = try container.decode(String.self, forKey: .label)
        self.image = try container.decode(String.self, forKey: .image)
        self.url = try container.decode(String.self, forKey: .url)
        self.yield = try container.decode(Float.self, forKey: .yield)
        self.ingredientLines = try container.decode([String].self, forKey: .ingredientLines)
        self.totalTime = try container.decode(Float.self, forKey: .totalTime)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}


