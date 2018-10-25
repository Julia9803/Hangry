//
//  RestaurantReviewCD+CoreDataProperties.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/22.
//  Copyright © 2018年 RMIT. All rights reserved.
//
//

import Foundation
import CoreData


extension RestaurantReviewCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantReviewCD> {
        return NSFetchRequest<RestaurantReviewCD>(entityName: "RestaurantReviewCD")
    }

    @NSManaged public var rating: String?
    @NSManaged public var review_text: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var username: String?
    @NSManaged public var user_level: Int64
    @NSManaged public var avatar: String?

}
