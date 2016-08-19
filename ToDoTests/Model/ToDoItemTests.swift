//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by wangqiang li on 8/3/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit_ShouldSetTitle() {
        let expectedTitle = "Test title"
        
        let item = ToDoItem(title: expectedTitle)
        
        XCTAssertEqual(item.title, expectedTitle, "Initializer should set the item title")
    }
    
    func testInit_ShouldSetTitleAndDescription() {
        let expectedDescription = "description"
        
        let item = ToDoItem(title: "Test title", itemDescription: expectedDescription)
        
        XCTAssertEqual(item.itemDescription, expectedDescription, "Initializer should set the item description")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let expectedTimestamp = 0.0
        
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: expectedTimestamp)
        
        XCTAssertEqual(item.timestamp, expectedTimestamp, "Initializer should set the timestamp")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        
        XCTAssertEqual(item.location?.name, location.name, "Initializer should set the location")
    }
    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: Location(name: "home"))
        let secondItem = ToDoItem(title: "First title", itemDescription: "First descripton", timestamp: 0.0, location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        var firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: nil)
        var secondItem = ToDoItem(title: "First title", itemDescription: "Frist description", timestamp: 0.0, location: Location(name: ""))
        firstItem = ToDoItem(title: "First title", itemDescription: "Frist description", timestamp: 0.0, location: Location(name: ""))

        secondItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: nil)
        
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 0.0, location: nil)
        let secondItem = ToDoItem(title: "First title", itemDescription: "First description", timestamp: 1.0, location: nil)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let fristItem = ToDoItem(title: "First title", itemDescription: "First description")
        let secondItem = ToDoItem(title: "First title", itemDescription: "second description")
        
        XCTAssertNotEqual(fristItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldBeNotEqual() {
        let firstItme = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        XCTAssertNotEqual(firstItme, secondItem)
    }
    
}
