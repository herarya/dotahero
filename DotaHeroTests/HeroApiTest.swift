//
//  HeroApiTest.swift
//  DotaHeroTests
//
//  Created by herman on 14/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import XCTest
@testable import DotaHero

class HeroApiTest: XCTestCase {
    
    var service : HeroesApiService?
    
    override func setUp() {
        service = HeroesApiService()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testGetHeroesApi() {
        weak var getHeroPromise = expectation(description: "get hero list on finish")
        
        service?.fetchHeroes(onSuccess: { data in
            XCTAssert(data != nil,"success data must be not-nil")
            getHeroPromise?.fulfill()
        }, onError: { error in
             XCTAssert(error != nil,"error data must be not-nil")
        })
        waitForExpectations(timeout: 3, handler: nil)
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
