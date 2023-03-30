//
//  SourceReportViewController.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/24/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import os.log

var reports = [SourceReport]()

class SourceReportViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var waterTypePicker: UIPickerView!
    @IBOutlet weak var waterConditionPicker: UIPickerView!
    @IBOutlet weak var longitudeVar: UITextField!
    @IBOutlet weak var latitudeVar: UITextField!
    
    let typeOptions = ["Bottled", "Well", "Lake", "Stream", "Other"]
    let conditionOptions = ["Treatable", "Potable", "Waste"]
    var waterCondition = "Bottled"
    var waterType = "Treatable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longitudeVar.delegate = self
        latitudeVar.delegate = self
        waterTypePicker.delegate = (self as UIPickerViewDelegate)
        waterTypePicker.dataSource = self
        waterConditionPicker.delegate = (self as UIPickerViewDelegate)
        waterConditionPicker.dataSource = self
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == waterConditionPicker) {
            return conditionOptions.count
        }
        else {
            return typeOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == waterConditionPicker) {
            return conditionOptions[row]
        }
        else {
            return typeOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == waterConditionPicker) {
            waterCondition = conditionOptions[row]
        }
        else {
            waterType = typeOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView == waterConditionPicker) {
            let titleData = conditionOptions[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.black])
            return myTitle
        } else {
            let titleData = typeOptions[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.black])
            return myTitle
        }
    }
    @IBAction func createReportPress(_ sender: Any) {
        //let defaultReport1 = SourceReport(title:"default1",coordinate:CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), info: "default1")
        var lat = Double(0)
        var long = Double(0)
        if (latitudeVar.text?.isEmpty)!{
        } else {
            lat = Double(latitudeVar.text!)!
        }
        if (longitudeVar.text?.isEmpty)!{
        } else {
            long = Double(longitudeVar.text!)!
        }
        let infoString = "WaterType:  \(waterType), WaterCondition: \(waterCondition))"
        let report = SourceReport(title: waterCondition, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), info: infoString);
        reports.append(report);
        let reportsData = NSKeyedArchiver.archivedData(withRootObject: reports)
        NSKeyedArchiver.archiveRootObject(reports, toFile: SourceReport.ArchiveURL.path)
        UserDefaults.standard.set(reportsData, forKey: "reports")
        UserDefaults.standard.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
