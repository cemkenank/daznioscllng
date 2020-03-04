//
//  ScoreTableViewCell.swift
//  DAZN Challange
//
//  Created by MrDark on 3.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet var teamALabel: UILabel!
    @IBOutlet var teamBLabel: UILabel!
    @IBOutlet var teamAPointLabel: UILabel!
    @IBOutlet var teamBPointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
