//
//  TableViewCell.swift
//  Todo Tasky
//
//  Created by sanamsuri on 06/10/18.
//  Copyright © 2018 sanamsuri. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var taskLbl: UILabel!
    
    
    // Variables
    
    
    // Constants
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
