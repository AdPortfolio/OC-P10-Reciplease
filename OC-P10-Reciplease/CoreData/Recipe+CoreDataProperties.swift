//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Walim Aloui on 16/08/2022.
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
    
    static func addRecipe(recipeCellVM: RecipeCellViewModel) {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if result.label == recipeCellVM.label  {
                    didFavorBarButton?()
                    print("recipe exists \(result.label)")
                    return
                } else {
                    print("recipe does not exist \(result.label)")
                }
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    static func removeRecipe(recipeCellVM: RecipeCellViewModel) {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if result.label == recipeCellVM.label  {
                    managedContext.delete(result)
                    try managedContext.save()
                    return
                } else {}
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    static func checkExistence(recipeCellVM: RecipeCellViewModel)  {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Recipe.label), ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        do {
            let managedContext = PersistenceController.shared.container.viewContext
            let results = try managedContext.fetch(fetchRequest)
            guard results.count > 0 else {
                didUnfavorBarButton?()
                return
            }
            for result in results {
                if result.label == recipeCellVM.label  {
                    didFavorBarButton?()
                    return  
                } else {
                    didUnfavorBarButton?()
                }
            }
        } catch {
            print("catched error in checkExistence method")
        }
    }

    static func createWith(label: String,
                           image: String,
                           ingredientLines: [String],
                           totalTime: Float,
                           url: String,
                           yield: Float,
                           favorites: Bool,
                           using managedObjectContext: NSManagedObjectContext) {
        let launch = Recipe(context: managedObjectContext)
        launch.label = label
        launch.image = image
        launch.ingredientLines = ingredientLines
        launch.totalTime = totalTime
        launch.url = url
        launch.yield = yield
        launch.favorites = favorites
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
