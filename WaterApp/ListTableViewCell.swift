//
//  ListTableViewCell.swift
//  WaterApp
//
//  Created by Hardik Sangwan on 4/25/17.
//  Copyright © 2017 Hardik Sangwan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
