//
//  User.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/8/21.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import Foundation
import UIKit

struct User {
    
    var email: String!
    var username: String!
    var password: String!
    
    var avatar: UIImage?
    
    var firstName: String?
    var lastName: String?
    
    var bookmarkRestaurant: Array<Restaurant>?
    //var bookmarkRecipe: Array<Recipe>?
    var historyRestaurant: Array<Restaurant>?
    //var historyRecipe: Array<Recipe>?
}
