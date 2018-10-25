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

class ResutaurantBookmarkCDModel {
    static let sharedInstance = ResutaurantBookmarkCDModel()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    // Create a collection of objects to store in the database
    var restaurantBookmarkdb = [RestaurantBookmarkCD]()
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getRestaurantBookmarkCD(_ indexPath: IndexPath) -> RestaurantBookmarkCD
    {
        return restaurantBookmarkdb[indexPath.row]
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
    
    func getRestaurantBookmarkCD()
    {
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"RestaurantBookmarkCD")
            
            let results =
                try managedContext.fetch(fetchRequest)
            restaurantBookmarkdb = results as! [RestaurantBookmarkCD]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func deleteRestaurantBookmarkCD(_ indexPath: IndexPath)
    {
        let restaurantBookmark = restaurantBookmarkdb[indexPath.item]
        restaurantBookmarkdb.remove(at: indexPath.item)
        managedContext.delete(restaurantBookmark)
        updateDatabase()
    }
    
    func easyDeleteRestaurantBookmarkCD(restaurantId: String) {
        let fetchRequest: NSFetchRequest = RestaurantBookmarkCD.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "RestaurantBookmarkCD",
                                                         in:managedContext)
        fetchRequest.predicate = NSPredicate.init(format: "restaurant_id = \(restaurantId)", "")
        if restaurantBookmarkdb.count > 0 {
            for index in 0...restaurantBookmarkdb.count-1 {
                if restaurantBookmarkdb[index].restaurant_id == restaurantId {
                    restaurantBookmarkdb.remove(at: index)
                }
            }
        }
        do {
            let result:[RestaurantBookmarkCD] = try managedContext.fetch(fetchRequest)
            for each in result {
                managedContext.delete(each)
                updateDatabase()
            }
        }catch {
            fatalError()
        }
    }
    
    func checkExist(restaurantId: String)->Bool {
        let fetchRequest: NSFetchRequest = RestaurantBookmarkCD.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "RestaurantBookmarkCD",
                                                         in:managedContext)
        fetchRequest.predicate = NSPredicate.init(format: "restaurant_id = \(restaurantId)", "")
        do {
            let result:[RestaurantBookmarkCD] = try managedContext.fetch(fetchRequest)
            
            if result.count == 0 {
                return false
            }else {
                return true
            }
            
        }catch {
            fatalError()
        }
        return false;
    }
    // MARK: - CRUD
    
    func saveRestaurantBookmarkCD(_ restaurant_id: String, restaurant_name:String, location:String, rating:String, rating_color:String, thumb:String, cuisines:String, existing: RestaurantBookmarkCD?)
    {
        // Create a new managed object and insert it into the context, so it can be saved
        // into the database
        let entity =  NSEntityDescription.entity(forEntityName: "RestaurantBookmarkCD", in:managedContext)
        
        let exist = checkExist(restaurantId: restaurant_id)
        // Update the existing object with the data passed in from the View Controller
        //if let _ = existing
        if exist {
            if let _ = existing {
                existing!.restaurant_id = restaurant_id
                existing!.restaurant_name = restaurant_name
                existing!.location = location
                existing!.rating = rating
                existing!.rating_color = rating_color
                existing!.thumb = thumb
                existing!.cuisines = cuisines
            }
        }
            // Create a new restaurantReviewCD object and update it with the data passed in from the View Controller
        else
        {
            // Create an object based on the Entity
            let restaurantBookmarkCD = RestaurantBookmarkCD(entity: entity!,
                                                        insertInto:managedContext)
            restaurantBookmarkCD.restaurant_id = restaurant_id
            restaurantBookmarkCD.restaurant_name = restaurant_name
            restaurantBookmarkCD.location = location
            restaurantBookmarkCD.rating = rating
            restaurantBookmarkCD.rating_color = rating_color
            restaurantBookmarkCD.thumb = thumb
            restaurantBookmarkCD.cuisines = cuisines
            
            restaurantBookmarkdb.append(restaurantBookmarkCD)
        }
        
        updateDatabase()
    }
}
