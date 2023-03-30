//
//  ViewController.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/24/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        reports += loadReports()
        mapView.addAnnotations(reports)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        let identifier = "SourceReport"
        
        // 2
        if annotation is SourceReport {
            // 3
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                //4
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                // 5
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                // 6
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        // 7
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let sourceReport = view.annotation as! SourceReport
        let waterCondition = sourceReport.title
        let waterType = sourceReport.info
        
        let ac = UIAlertController(title: waterCondition, message: waterType, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }
        

    }
    
    @IBAction func logoutTap(_ sender: Any) {
        UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    
    @IBAction func reportTap(_ sender: Any) {
        let userType = UserDefaults.standard.string(forKey: "userType")
        if (userType == "User") {
            self.performSegue(withIdentifier: "userView", sender: self);
        }
        if (userType == "Worker") {
            self.performSegue(withIdentifier: "workerView", sender: self);
        }
        if (userType == "Manager" || userType == "Admin") {
            self.performSegue(withIdentifier: "managerView", sender: self);
        }
    }
    
    private func loadReports() -> [SourceReport]  {
/*      guard let reportsData = UserDefaults.standard.object(forKey: "reports") as? NSData else {
            print("'reports' not found in UserDefaults")
            return [SourceReport(title:"default1",coordinate:CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), info: "default1")]
        }
        guard let reportArr = NSKeyedUnarchiver.unarchiveObject(with: reportsData as Data) as? [SourceReport] else {
            print("'reports' not found in UserDefaults")
            return [SourceReport(title:"default1",coordinate:CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), info: "default1")]
        }
        UserDefaults.standard.synchronize()
        return reportArr
 */
        if let reportsData = NSKeyedUnarchiver.unarchiveObject(withFile: SourceReport.ArchiveURL.path) as? [SourceReport] {
            return reportsData
        }
        return [SourceReport(title:"default1",coordinate:CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), info: "default1")]
    }
}

