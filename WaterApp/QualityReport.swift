//
//  QualityReport.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/25/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import os.log

class QualityReport: NSObject, NSCoding, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reports")
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(info, forKey: "info")
        aCoder.encode(coordinate.latitude, forKey: "lat")
        aCoder.encode(coordinate.longitude, forKey: "long")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let waterCondition = aDecoder.decodeObject(forKey: "title") as? String else {
            os_log("Unable to decode the waterCondition for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let waterType = aDecoder.decodeObject(forKey: "info") as? String else {
            os_log("Unable to decode the waterType for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let lat = aDecoder.decodeDouble(forKey:"lat")
        let long = aDecoder.decodeDouble(forKey: "long")
        let waterLocation = CLLocationCoordinate2D(latitude: lat, longitude: long);
        
        // Must call designated initializer.
        self.init(title: waterCondition,  coordinate: waterLocation , info: waterType)
        
    }
}
