//
//  AllowedContentViewModelTests.swift
//  BlackListTests
//
//  Created by Robert Ryan on 4/27/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import XCTest

@testable import BlackList

class AllowedContentViewModelTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDefaultState() {
        let viewModel = AllowedContentViewModel(allowed: [], flags: [])
        
        XCTAssert(!viewModel.isSelected(row: 0))
        XCTAssert(!viewModel.isSelected(row: 1))
        XCTAssert(viewModel.isSelected(row: 2))
        XCTAssert(viewModel.isSelected(row: 3))
    }
    
    func testTogglingNsfw() {
        var viewModel = AllowedContentViewModel(allowed: [], flags: [.nsfw])
        
        XCTAssert(viewModel.isSelected(row: 0))
        
        viewModel.toggle(row: 0)
        
        XCTAssert(!viewModel.isSelected(row: 0))
    }
    
}
