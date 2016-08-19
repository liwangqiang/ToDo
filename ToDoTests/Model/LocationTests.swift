//
//  LocationTests.swift
//  ToDo
//
//  Created by wangqiang li on 8/19/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {
    
    func testInit_ShouldSetName() {
        let location = Location(name: "Test name")
        
        XCTAssertEqual(location.name, "Test name", "Initializer should set the name")
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)
        
        let location = Location(name: "Test name", coordinate: coordinate)
        XCTAssertEqual(coordinate.latitude, location.coordinate?.latitude, "Initializer should set the coordinate")
        XCTAssertEqual(coordinate.longitude, location.coordinate?.longitude, "Initializer should set the coordinate")
    }
    
    func testEqualLocations_ShouldBeEqual() {
        let first = Location(name: "Home")
        let second = Location(name: "Home")
        
        XCTAssertEqual(first, second)
    }
    
    func testWhenLatitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0))
    }
    
    func testWhenLongitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0, 0.0), secondLongLat: (0.0, 1.0))
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0, 0.0), secondLongLat: nil)
    }
    
    func testWhenNameDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Office", firstLongLat: nil, secondLongLat: nil)
    }
    
    
    private func performNotEqualTestWithLocationProperties(firstName: String, secondName: String, firstLongLat: (Double, Double)?, secondLongLat: (Double, Double)?, line: UInt = #line) {
        
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        } else {
            secondCoord = nil
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }

}
