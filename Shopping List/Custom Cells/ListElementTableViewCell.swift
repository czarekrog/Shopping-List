//
//  ListElementTableViewCell.swift
//  Shopping List
//
//  Created by Cezary Róg on 23.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import UIKit

class ListElementTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var elementCheckedButton: UIView!
    @IBOutlet weak var listElementName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
