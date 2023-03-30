//
//  LoginViewController.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/24/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self
        pass.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func loginTap(_ sender: Any) {
        let userEmail = user.text
        let userPass = pass.text
        let isUserLoggedIn = false
        UserDefaults.standard.set(isUserLoggedIn, forKey:"isUserLoggedIn")
        users += loadUsers()
        for i in 0 ..< users.count {
            if(users[i].userName == userEmail)
            {
                if(users[i].password == userPass)
                {
                    // Login is successfull
                    UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                    UserDefaults.standard.synchronize();
                    
                    self.dismiss(animated: true, completion:nil);
                } else {
                    displayMyAlertMessage(userMessage: "Incorrect Password");
                }
            }
        }
        if (users[users.count-1].userName != userEmail) {
            displayMyAlertMessage(userMessage: "User does not exist");
        }
        
    }
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    private func loadUsers() -> [User]  {
        if let usersData = NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? [User] {
            return usersData
        }
        return [User(userName: "wq", password: "wsd")]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
