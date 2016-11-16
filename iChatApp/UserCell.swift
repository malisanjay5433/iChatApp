//
//  UserCell.swift
//  iChatApp
//
//  Created by Sanjay Mali on 13/11/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var userAvatar:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
