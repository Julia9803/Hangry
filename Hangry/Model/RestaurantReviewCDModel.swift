//
//  Model.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/22.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RestaurantReviewCDModel {
    static let sharedInstance = RestaurantReviewCDModel()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    // Create a collection of objects to store in the database
    var restaurantReviewdb = [RestaurantReviewCD]()
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getRestaurantReviewCD(_ indexPath: IndexPath) -> RestaurantReviewCD
    {
        return restaurantReviewdb[indexPath.row]
    }
    
    // Save the current state of the objects in the managed context into the
    // database.
    func updateDatabase()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getRestaurantReviewCD()
    {
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"RestaurantReviewCD")
            
            let results =
                try managedContext.fetch(fetchRequest)
            restaurantReviewdb = results as! [RestaurantReviewCD]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func deleteRestaurantReviewCD(_ indexPath: IndexPath)
    {
        let restaurantReview = restaurantReviewdb[indexPath.item]
        restaurantReviewdb.remove(at: indexPath.item)
        managedContext.delete(restaurantReview)
        updateDatabase()
    }
    
    // MARK: - CRUD
    
    func saveRestaurantReviewCD(_ rating: String, review_text:String, time:NSDate, username:String, user_level:Int64, avatar:String, existing: RestaurantReviewCD?)
    {
        // Create a new managed object and insert it into the context, so it can be saved
        // into the database
        let entity =  NSEntityDescription.entity(forEntityName: "RestaurantReviewCD",
                                                 in:managedContext)
        
        // Update the existing object with the data passed in from the View Controller
        if let _ = existing
        {
            existing!.rating = rating
            existing!.review_text = review_text
            existing!.time = time
            existing!.username = username
            existing!.user_level = user_level
            existing!.avatar = avatar
        }
            // Create a new restaurantReviewCD object and update it with the data passed in from the View Controller
        else
        {
            // Create an object based on the Entity
            let restaurantReviewCD = RestaurantReviewCD(entity: entity!,
                              insertInto:managedContext)
            restaurantReviewCD.rating = rating
            restaurantReviewCD.review_text = review_text
            restaurantReviewCD.time = time
            restaurantReviewCD.username = username
            
            if(avatar == ""){
                restaurantReviewCD.avatar = "default_avatar"
            }
            else{
                restaurantReviewCD.avatar = avatar
            }
            
            if(user_level == 0){
                restaurantReviewCD.user_level = 1
            }else{
                restaurantReviewCD.user_level = user_level
            }
            
            restaurantReviewdb.append(restaurantReviewCD)
        }
        
        updateDatabase()
    }
}
