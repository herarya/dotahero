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
        print(data)
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            let managedContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedContext
            let heroes = try decoder.decode([HeroModel].self, from: data)
            storeRole(role: "All",context: managedContext)
            print(heroes.count)
            heroes.forEach { hero in
                for role in hero.roles where !isRoleExist(context:managedContext,role:role) {
                    storeRole(role: role,context: managedContext)
                }
            }
            saveContext()
        } catch {
            debugPrint("Error save db")
        }
    }
    
    func isRoleExist(context: NSManagedObjectContext,role:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RoleModel")
        fetchRequest.predicate = NSPredicate(format: "name == %@", role)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    func storeRole(role:String,context: NSManagedObjectContext) {

        let entity = NSEntityDescription.entity(forEntityName: "RoleModel", in: context)!
        let roleModel = NSManagedObject(entity: entity, insertInto: context)
        roleModel.setValue(role, forKey: "name")
    }
    
    func fetchRoles() -> [RoleModel]? {
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"RoleModel")
        fetchRequest.sortDescriptors = [sortByName]
        do {
            var roles = [RoleModel]()
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for item in results {
                if let data = item as? RoleModel {
                    roles.append(data)
                }
            }
            return roles
        } catch {
            debugPrint("error fetching db roles")
            return nil
        }
    }
    
    
    
}
