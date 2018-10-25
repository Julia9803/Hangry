//
//  RestaurantBookmarkCD+CoreDataProperties.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/22.
//  Copyright © 2018年 RMIT. All rights reserved.
//
//

import Foundation
import CoreData


extension RestaurantBookmarkCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantBookmarkCD> {
        return NSFetchRequest<RestaurantBookmarkCD>(entityName: "RestaurantBookmarkCD")
    }

    @NSManaged public var restaurant_id: String?
    @NSManaged public var restaurant_name: String?
    @NSManaged public var location: String?
    @NSManaged public var rating: String?
    @NSManaged public var rating_color: String?
    @NSManaged public var thumb: String?
    @NSManaged public var cuisines: String?

}
