//
//  HeroModel.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//


import Foundation
import CoreData

//codable NSManagedObject Coredata
//https://medium.com/@andrea.prearo/working-with-codable-and-core-data-83983e77198e

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

enum HeroModelCodingKeys: String,CodingKey {
    case maxAttack = "base_attack_max"
    case baseHealth = "base_health"
    case idHero = "hero_id"
    case image = "img"
    case localizedName = "localized_name"
    case moveSpeed = "move_speed"
    case primaryAttr = "primary_attr"
    case baseAarmor = "base_mana"
    case roles
}


@objc(HeroModel)
public class HeroModel: NSManagedObject, Codable{
    
    
    // MARK: - Core Data Managed Object
    @NSManaged var maxAttack: Double
    @NSManaged var baseHealth: Double
    @NSManaged var idHero: Double
    @NSManaged var image: String
    @NSManaged var localizedName: String
    @NSManaged var moveSpeed: Double
    @NSManaged var primaryAttr: String
    @NSManaged var roles: [String]
    @NSManaged var baseAarmor: Double

    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: HeroModelCodingKeys.self)
        try container.encode(maxAttack, forKey: .maxAttack)
        try container.encode(baseHealth, forKey: .baseHealth)
        try container.encode(idHero, forKey: .idHero)
        try container.encode(image, forKey: .image)
        try container.encode(localizedName, forKey: .localizedName)
        try container.encode(moveSpeed, forKey: .moveSpeed)
        try container.encode(primaryAttr, forKey: .primaryAttr)
        try container.encode(roles, forKey: .roles)
        try container.encode(baseAarmor, forKey: .baseAarmor)
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "HeroModel", in: managedObjectContext) else {
                fatalError("Failed to decode Model")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: HeroModelCodingKeys.self)
        do {
            self.maxAttack = try container.decode(Double.self, forKey: .maxAttack)
            self.baseHealth = try container.decode(Double.self, forKey: .baseHealth)
            self.idHero = try container.decode(Double.self, forKey: .idHero)
            self.image = try container.decode(String.self, forKey: .image)
            self.localizedName = try container.decode(String.self, forKey: .localizedName)
            self.moveSpeed = try container.decode(Double.self, forKey: .moveSpeed)
            self.primaryAttr = try container.decode(String.self, forKey: .primaryAttr)
            self.roles = try container.decode([String].self, forKey: .roles)
            self.baseAarmor = try container.decode(Double.self, forKey: .baseAarmor)
        } catch {
            debugPrint("erro decode")
        }
    }
    

    
    
}

