//
//  WeatherCell.swift
//  weather_app
//
//  Created by Tuukka Juusela on 14/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit

class WeatherCell : UITableViewCell {    
    @IBOutlet weak var boldTitleLabel: UILabel!
    @IBOutlet weak var normalTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subSubTitleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
