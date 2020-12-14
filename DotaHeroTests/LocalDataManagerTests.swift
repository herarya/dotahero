//
//  LocalDataManagerTests.swift
//  DotaHeroTests
//
//  Created by herman on 14/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import XCTest
import CoreData
@testable import DotaHero

class LocalDataManagerTests: XCTestCase {
    
    var localDataMock : LocalDataManager?
    var persistentContainer: NSPersistentContainer?
    
    override func setUp() {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "DotaHero")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
             if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
             }
        }
        persistentContainer = container
        localDataMock = LocalDataManager(persistentContainer: container)

    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInsertDataToLocalDb() throws {
       guard let path = Bundle.main.url(forResource: "HeroList", withExtension: "json") else {
            XCTAssert(false, "Can't find HeroList.json file")
            return
        }
        
        let data = try! Data(contentsOf: path)
        localDataMock?.store(data: data)
        
        //fecth data hero from db
        let heroes = localDataMock?.fetchHeroes()
        let roles  = localDataMock?.fetchRoles()
        XCTAssertTrue(heroes!.count > 0,"insert data hero work correctly")
        XCTAssertTrue(roles!.count > 0,"insert data roles work correctly")
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
