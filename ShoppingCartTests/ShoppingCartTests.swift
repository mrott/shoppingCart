//
//  ShoppingCartTests.swift
//  ShoppingCartTests
//
//  Created by Rott Marius Gabriel on 01/02/2018.
//  Copyright © 2018 Rott Marius Gabriel. All rights reserved.
//

import XCTest

class ShoppingCartTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCurrencyNetworkRequest() {
        let expectation = XCTestExpectation(description: "Making NetworkRequest api call")
        
        NetworkRequest.getCurrencies { (completed, currencies) in
            XCTAssert(completed, "Can't complete NetworkRequest - Currencies")
            
            XCTAssert(currencies.count > 0, "No currencies were retrieved from the server")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
