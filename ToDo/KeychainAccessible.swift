//
//  KeychainAccessible.swift
//  ToDo
//
//  Created by 李王强 on 16/8/28.
//  Copyright © 2016年 Bruce Li. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
    func setPassword(password: String, account: String)
    
    func deletePasswordForAccount(account: String)
    
    func passwordForAccount(account: String) -> String?
}