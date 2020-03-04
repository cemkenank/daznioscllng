//
//  NewsTableViewCell.swift
//  DAZN Challange
//
//  Created by MrDark on 3.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsPubDateLabel: UILabel!
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsDescriptionLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

