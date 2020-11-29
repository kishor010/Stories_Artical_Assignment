//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import KaodimAssignment


var viewModel: StoriesViewModel!

class KaodimAssignmentTests: XCTestCase {

    override func setUp() {
        viewModel = StoriesViewModel.init()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        super.tearDown()
    }

    func testExample() {
        XCTAssertNil(viewModel.parseData(jsonData: nil, indexValue: 20))
        (viewModel.apiCallForItemDetails(itemId: "", noAt: 0, completed: { (model) in
        }))
        
        XCTAssertNotNil(viewModel)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFailure()  {
        XCTAssertNil(viewModel)
        XCTAssertNotNil(viewModel.parseData(jsonData: nil, indexValue: nil))
        XCTAssertNil(viewModel.apiCallForItemDetails(itemId: "", noAt: nil, completed: { (model) in
        }))
    }
    
    func testEqual()  {
        
        let model = viewModel.bindModel(by: nil, descendants: nil, itemId: nil, score: nil, parentId: nil, time: nil, indexValue: nil, title: nil, type: nil, url: nil, kids: nil)
        
        XCTAssertTrue((viewModel.parseData(jsonData: nil, indexValue: nil) == nil))
        XCTAssertTrue((viewModel.parseData(jsonData: JSON(), indexValue: 0) != nil))
        
        XCTAssertTrue(model != nil)
        XCTAssertTrue(model?.by == nil)
        XCTAssertFalse(model?.id != nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            viewModel.getStories(count: 30)
        }
    }

}
