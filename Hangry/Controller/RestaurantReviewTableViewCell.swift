//
//  RestaurantReviewTableViewCell.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/16.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit

class RestaurantReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var reviewTime: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
