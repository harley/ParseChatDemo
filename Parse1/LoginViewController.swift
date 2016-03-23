//
//  ViewController.swift
//  Parse1
//
//  Created by Harley Trung on 3/23/16.
//  Copyright © 2016 coderschool.vn. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    var user: PFUser!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginAction(sender: UIButton) {
        login()
    }
    @IBAction func signupAction(sender: UIButton) {
        signup()
    }
    func login() {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            guard let user = user else {
                self.displayMessage(error!.userInfo["error"] as! String)
                return
            }
            
            self.user = user
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
    func displayMessage(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func signup() {
        user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            guard succeeded == true else {
                let errorString = error!.userInfo["error"] as! String
                self.displayMessage(errorString)
                return
            }
            
            // Hooray! Let them use the app now.
            print("hooray: \(self.user.username)")
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
    func testParse() {
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nvc = segue.destinationViewController as! UINavigationController
        let vc = nvc.topViewController as! ChatViewController
        vc.title = user.username
        vc.user = user
    }
}