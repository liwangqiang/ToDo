//
//  DetailViewController.swift
//  ToDo
//
//  Created by wangqiang li on 8/24/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkButton: UIButton!
    
    lazy var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    var itemInfo: (ItemManager, Int)?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let itemInfo = itemInfo else { return }
        let item = itemInfo.0.itemAtIndex(itemInfo.1)
        
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        
        if let timestamp = item.timestamp {
            let date = NSDate(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.stringFromDate(date)
        }
        
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            mapView.region = region
        }
    }
    
    @IBAction func clichCheckButtonHander(sender: UIButton) {
        checkItem()
    }
    
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItemAtIndex(itemInfo.1)
        }
    }
}
