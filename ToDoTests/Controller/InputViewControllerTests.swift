//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by wangqiang li on 8/24/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placemark: MockPlacemark!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    func test_HasDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func test_HasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func test_HasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func test_HasAddressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func test_HasCancelButton() {
        XCTAssertNotNil(sut.cancelButton)
    }
    
    func test_HasSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Text Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.3316851, longitude: -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Text Title", itemDescription: "Test Description", timestamp: 1456070400, location: Location(name: "Office", coordinate: coordinate))
        
        XCTAssertEqual(testItem, item)
    }
    
    func testSave_OnlyHasTitle_SaveInItemManager() {
        sut.titleTextField.text = "Text Title"
        sut.dateTextField.text = nil
        sut.locationTextField.text = nil
        sut.descriptionTextField.text = nil
        sut.addressTextField.text = nil
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        let item = sut.itemManager?.itemAtIndex(0)
        let testItem = ToDoItem(title: "Text Title")
        
        XCTAssertEqual(item, testItem)
    }
    
    func testSaveButton_ClickToSave() {
        sut.titleTextField.text = "Text Title"
        sut.dateTextField.text = nil
        sut.locationTextField.text = nil
        sut.descriptionTextField.text = nil
        sut.addressTextField.text = nil
        
        sut.itemManager = ItemManager()
        
        sut.saveButton.sendActionsForControlEvents(.TouchUpInside)
        let item = sut.itemManager?.itemAtIndex(0)
        let testItem = ToDoItem(title: "Text Title")
        
        XCTAssertEqual(item, testItem)
    }
    
    func testSaveButton_HasSaveAction() {
        guard let actions = sut.saveButton.actionsForTarget(sut, forControlEvent: .TouchUpInside) else {
            XCTFail(); return
        }
        
        XCTAssert(actions.contains("save"))
    }
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
        
    }
    
    class MockPlacemark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else {
                return CLLocation()
            }
            
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
        }
    }
}
