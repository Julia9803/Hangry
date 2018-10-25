//
//  RestaurantBookmarkTableViewController.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/22.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit

class RestaurantBookmarkTableViewController: UITableViewController {

    var bookmarkModel:ResutaurantBookmarkCDModel = ResutaurantBookmarkCDModel.sharedInstance
    var currentRestaurant:RestaurantBookmarkCD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarkModel.getRestaurantBookmarkCD()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyborad.instantiateViewController(withIdentifier: "RestaurantDetail") as! RestaurantDetailViewController
        
        dvc.getRestaurantName = bookmarkModel.restaurantBookmarkdb[indexPath.row].restaurant_name!
        dvc.getCuisines = bookmarkModel.restaurantBookmarkdb[indexPath.row].cuisines!
        dvc.getRating = bookmarkModel.restaurantBookmarkdb[indexPath.row].rating!
        dvc.getRatingColor = ""
        dvc.getRestaurantId = bookmarkModel.restaurantBookmarkdb[indexPath.row].restaurant_id!
        dvc.getLocation = bookmarkModel.restaurantBookmarkdb[indexPath.row].location!
        dvc.getMenu = ""
        dvc.getRestaurantImg = bookmarkModel.restaurantBookmarkdb[indexPath.row].thumb!
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarkModel.restaurantBookmarkdb.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantBookmarkCell", for: indexPath) as! RestaurantBookmarkTableViewCell
        
        cell.restaurantName.text = bookmarkModel.restaurantBookmarkdb[indexPath.item].restaurant_name
        cell.restaurantLocation.text = bookmarkModel.restaurantBookmarkdb[indexPath.item].location
        cell.restaurantCuisines.text = bookmarkModel.restaurantBookmarkdb[indexPath.item].cuisines
        cell.restaurantRating.text = bookmarkModel.restaurantBookmarkdb[indexPath.item].rating
        
        let url = URL(string: bookmarkModel.restaurantBookmarkdb[indexPath.item].thumb!)
        let data = try! Data(contentsOf: url!)
        cell.restaurantImg.image = UIImage(data: data)
        
        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        bookmarkModel.deleteRestaurantBookmarkCD(indexPath)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
