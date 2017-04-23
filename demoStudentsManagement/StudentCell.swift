//
//  StudentCell.swift
//  demoStudentsManagement
//
//  Created by Hung Nguyen on 4/17/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
class StudentCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
