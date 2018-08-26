//
//  ListTableViewCell.swift
//  Shopping List
//
//  Created by Cezary Róg on 22.08.2018.
//  Copyright © 2018 Cezary Róg. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var shoppingListCell: UIView!
    @IBOutlet weak var shoppingListIcon: UIImageView!
    @IBOutlet weak var shoppingListTitleLabel: UILabel!
    @IBOutlet weak var numberOfShoppingListElementsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shoppingListCell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        shoppingListCell.layer.shadowOpacity = 0.7
        shoppingListCell.layer.shadowOffset = CGSize(width: 2, height: 2)
        shoppingListCell.layer.shadowRadius = 5
        shoppingListCell.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
