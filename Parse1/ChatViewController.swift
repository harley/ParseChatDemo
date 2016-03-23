//
//  ChatViewController.swift
//  Parse1
//
//  Created by Harley Trung on 3/23/16.
//  Copyright © 2016 coderschool.vn. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
    var messages: [PFObject]?
    
    @IBOutlet weak var logoutButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func sendAction(sender: UIButton) {
        let message = PFObject(className: "Message_Swift_032016")
        let user = PFUser.currentUser()
        
        message["body"] = messageField.text!
        message["user"] = user
        
        message.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            guard succeeded else {
                print("Error: \(error!.description)")
                return
            }
            
            print("Posted message: \(self.messageField.text) from \(user)")
            self.messageField.text = ""
        }
    }
    
    func loadMessages() {
        let query = PFQuery(className: "Message_Swift_032016")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            guard let objects = objects else {
                print("Error: \(error!.description)")
                return
            }
            
            print("loaded \(objects.count) messages")
            self.messages = objects
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "loadMessages", userInfo: nil, repeats: true)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        cell.message = messages![indexPath.row]
        return cell
    }
}
