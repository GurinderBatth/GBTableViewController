//
//  GBTableViewCell.swift
//  GBTableView
//
//  Created by IOS on 26/01/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class GBTableViewCell<D: Codable>: UITableViewCell {
    
    var data: D?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
