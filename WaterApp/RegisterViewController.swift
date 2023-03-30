//
//  RegisterViewController.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/24/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit

var users = [User]()

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var pickView: UIPickerView!
    
    let pickOptions = ["User", "Worker", "Manager", "Admin"]
    var userType = "User"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self
        pass.delegate = self
        repeatPass.delegate = self
        pickView.delegate = (self as UIPickerViewDelegate)
        pickView.dataSource = self
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
        return pickOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userType = pickOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickOptions[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
    
    
    @IBAction func registerTap(_ sender: AnyObject) {
        let userEmail = user.text;
        let userPass = pass.text;
        let userRepeat = repeatPass.text;
        
        if((userEmail?.isEmpty)! || (userPass?.isEmpty)! || (userRepeat?.isEmpty)!)
        {
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        if(userPass != userRepeat) {
            displayMyAlertMessage(userMessage: "Passwords do not match");
            return;
        }
        UserDefaults.standard.set(userType, forKey: "userType")
        let userVar = User(userName: userEmail!, password: userPass!)
        users.append(userVar)
        NSKeyedArchiver.archiveRootObject(users, toFile: User.ArchiveURL.path)
        let usersData = NSKeyedArchiver.archivedData(withRootObject: users)
        UserDefaults.standard.set(usersData, forKey: "users")
        UserDefaults.standard.synchronize()
        
        let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
            self.dismiss(animated: true, completion:nil);
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
