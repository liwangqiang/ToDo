//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by wangqiang li on 8/22/16.
//  Copyright © 2016 Bruce Li. All rights reserved.
//

import UIKit

enum Section: Int {
    case ToDo
    case Done
}

let ItemCellIdentifier = "ItemCell"

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var itemManager: ItemManager?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        
        let numberOfRows: Int
        switch itemSection {
        case .ToDo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount
        }
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let itemManager = itemManager else { fatalError() }
        guard let itemSection = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        let item: ToDoItem
        switch itemSection {
        case .ToDo:
            item = itemManager.itemAtIndex(indexPath.row)
        default:
            item = itemManager.doneItemAtIndex(indexPath.row)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemCell
        cell.configCellWithItem(item)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        guard let itemSection = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch itemSection {
        case .ToDo:
            return "Check"
        case .Done:
            return "Uncheck"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let itemManager = itemManager else { fatalError() }
        guard let itemSection = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch itemSection {
        case .ToDo:
            itemManager.checkItemAtIndex(indexPath.row)
        case .Done:
            itemManager.uncheckItemAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }
}
