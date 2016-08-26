//
//  InputViewController.swift
//  ToDo
//
//  Created by wangqiang li on 8/24/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var itemManager: ItemManager?
    lazy var geocoder = CLGeocoder()
    
    @IBAction func save() {
        guard let titleString = titleTextField.text where titleString.characters.count > 0  else { return }
        
        let date = availableTextFrom(dateTextField) >>= dateFormatter.dateFromString
        let descriptionString = availableTextFrom(descriptionTextField)
    
        if let locationName = availableTextFrom(locationTextField), let address = availableTextFrom(addressTextField) {
            geocoder.geocodeAddressString(address, completionHandler: { [unowned self] (placemarks, error) in
                
                let placemark = placemarks?.first
                let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placemark?.location?.coordinate))
                self.itemManager?.addItem(item)
                
            })
        } else {
            let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970)
            self.itemManager?.addItem(item)
        }
    }
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    func availableTextFrom(textField: UITextField) -> String? {
        if let text = textField.text where text.characters.count > 0 {
            return text
        }
        return nil
    }
}

func >>=<T, U>(l: T?, r: (T -> U?)) -> U? {
    if let o = l {
        return r(o)
    }
    return nil
}
