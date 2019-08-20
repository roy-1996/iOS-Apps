//
//  ArticleCell.swift
//  News App
//
//  Created by RONIT NATH on 13/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Author: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
