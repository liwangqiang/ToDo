//
//  APIClient.swift
//  ToDo
//
//  Created by 李王强 on 16/8/28.
//  Copyright © 2016年 Bruce Li. All rights reserved.
//

import UIKit

class APIClient {

    lazy var session: ToDoURLSession = NSURLSession.sharedSession()
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(name: String, password: String, completion: (ErrorType? -> Void)) {
        let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet
        guard let encodedUsername = name.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        guard let encodedPassword = password.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        guard let url = NSURL.init(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else {
            fatalError()
        }
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) in
            guard error == nil else {
                completion(WebserviceError.ResponseError(error!))
                return
            }
            
            if let theData = data {
                do {
                    let responseDict = try NSJSONSerialization.JSONObjectWithData(theData, options: [])
                    let token = responseDict["token"] as! String
                    self.keychainManager?.setPassword(token, account: "token")
                } catch {
                    completion(error)
                }
            } else {
                completion(WebserviceError.DataEmptyError)
            }
        }
        dataTask.resume()
    }
}

protocol ToDoURLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: ((NSData?, NSURLResponse?, NSError?) -> Void)) -> NSURLSessionDataTask
}

extension NSURLSession: ToDoURLSession{}

enum WebserviceError: ErrorType {
    case DataEmptyError
    case ResponseError(NSError)
}
