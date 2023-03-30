//
//  User.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/25/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit
import os.log

class User: NSObject, NSCoding {
    var userName: String
    var password: String
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(password, forKey: "password")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let userName = aDecoder.decodeObject(forKey: "userName") as? String else {
            os_log("Unable to decode the waterCondition for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let password = aDecoder.decodeObject(forKey: "password") as? String else {
            os_log("Unable to decode the waterType for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(userName: userName, password: password)
        
    }
}
