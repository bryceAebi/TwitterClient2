//
//  MenuTableViewCell.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
