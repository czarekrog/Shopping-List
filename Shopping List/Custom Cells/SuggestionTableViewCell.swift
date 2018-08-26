//
//  SuggestionTableViewCell.swift
//  Shopping List
//
//  Created by Cezary Róg on 23.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var suggestionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
