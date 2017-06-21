//
//  TableViewCell.swift
//  StudentUseCoreData
//
//  Created by Hung Nguyen on 6/3/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var phoneNumTextField: UILabel!
    @IBOutlet weak var avartar: ImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
