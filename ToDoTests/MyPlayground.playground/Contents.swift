//: Playground - noun: a place where people can play

import Cocoa

let dateText = "02/22/2016"
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "MM/dd/yyyy"
let date = dateFormatter.dateFromString(dateText)
let timestamp = date?.timeIntervalSince1970

let timestamp1: NSTimeInterval = 1456095600
let date1 = NSDate(timeIntervalSince1970: timestamp1)
let dateText1 = dateFormatter.stringFromDate(date1)

let x: Bool
x = true
x = false