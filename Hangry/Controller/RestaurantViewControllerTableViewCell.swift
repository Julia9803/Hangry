//
//  RestaurantViewControllerTableViewCell.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/10.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit

class RestaurantViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var cuisines: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
