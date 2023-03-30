//
//  ListTableViewController.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/25/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit
import MapKit
import os.log
import CoreLocation

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reports.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell.")
        }
        
        // Fetches the appropriate report for the data source layout.
        let report = reports[indexPath.row]
        
        cell.nameLabel.text = report.info
        
        return cell

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            reports.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
