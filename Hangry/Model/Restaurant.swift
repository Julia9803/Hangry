//
//  Restaurant.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/8/21.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import Foundation
import UIKit

struct Restaurant {
    var id: String!
    var name: String!
    var location: String!
    var menu: String?
    var review: Array<String>?
    var thumb: String?
    var costForTwo: Double?
    var cuisines: String!
    var rating: String!
    var rating_color: String!
    
    mutating func initRestaurant(id: String,name: String,location: String,menu: String,thumb: String,costForTwo: Double,cuisines: String,rating: String,rating_color: String) {
        self.id = id;
        self.location = location;
        self.location = location
        self.thumb = thumb
        self.costForTwo = costForTwo
        self.cuisines = cuisines
        self.rating = rating
        self.rating_color = rating_color
    }
}
