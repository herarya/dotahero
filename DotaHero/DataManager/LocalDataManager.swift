//
//  LocalDataManager.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import CoreData

//fix https://stackoverflow.com/questions/52082117/coredata-codable-not-saving
class LocalDataManager: NSObject {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func fetchHeroes() -> [HeroModel]? {
        let sortByName = NSSortDescriptor(key: "localizedName", ascending: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"HeroModel")
        fetchRequest.sortDescriptors = [sortByName]
        do {
            var heroes = [HeroModel]()
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for item in results {
                if let data = item as? HeroModel {
                  heroes.append(data)
                }
            }
            return heroes
        } catch {
            debugPrint("error fetching db heroes")
            return nil
        }
    }


    func store(data: Data) {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            let managedContext = persistentContainer.viewContext
            print(managedContext)
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedContext
            _ = try decoder.decode([HeroModel].self, from: data)
            saveContext()
        } catch {
            debugPrint("Error save db")
        }
    }
    
    
}
