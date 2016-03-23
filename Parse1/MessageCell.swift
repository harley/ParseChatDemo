//
//  MessageCell.swift
//  Parse1
//
//  Created by Harley Trung on 3/23/16.
//  Copyright © 2016 coderschool.vn. All rights reserved.
//

import UIKit
import Parse
import NSDate_TimeAgo

class MessageCell: UITableViewCell {
    @IBOutlet weak var timeAgoLabel: UILabel!
    var message: PFObject! {
        didSet {
            bodyLabel.text = message["text"] as? String ?? "<empty>"
            if let user = message["user"] as? PFUser {
                senderLabel.text = user.username
            } else {
                senderLabel.text = "<anonymous>"
            }
            timeAgoLabel.text = message.createdAt?.timeAgo()
        }
    }
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
}
