//
//  MessageCell.swift
//  Parse1
//
//  Created by Harley Trung on 3/23/16.
//  Copyright © 2016 coderschool.vn. All rights reserved.
//

import UIKit
import Parse

class MessageCell: UITableViewCell {
    var message: PFObject! {
        didSet {
            bodyLabel.text = message["body"] as? String ?? "<empty>"
            if let user = message["user"] as? PFUser {
                senderLabel.text = user.username
            } else {
                senderLabel.text = "<anonymous>"
            }
        }
    }
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
}
