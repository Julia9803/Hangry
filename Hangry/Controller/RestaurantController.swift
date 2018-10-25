//
//  RestaurantViewController.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/8/17.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var tableView: UITableView!
    var bookmarkDb = ResutaurantBookmarkCDModel.sharedInstance.restaurantBookmarkdb
    
    let restaurants = ["restaurant1","restaurant2","restaurant3","restaurant1","restaurant2","restaurant3","restaurant1","restaurant2","restaurant3"];
    var sizeOfRestaurants = 0;
    var restaurantArray: [Restaurant] = []
    
    let BASE_URL:String = "https://developers.zomato.com/api/v2.1/"
    let CITY:String = "cities?q=melbourne"
    let CITY_COUNT:String = "count=1"
    let GEO_CODE:String = "geocode?"
    var LATITUDE:String = "lat=-37.8056733"
    var LONGITUDE:String = "lon=144.9623021"
    let API_KEY:String = "6c1d4d9b6d74ca97218eb59883f8c3ed"

    public func getRestaurantArray() -> [Restaurant]{
        return self.restaurantArray;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("!!!!!!!!!!!!" , self.sizeOfRestaurants)
        if(self.sizeOfRestaurants == 0){
            return restaurants.count;
        }else{
            return self.sizeOfRestaurants;
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RestaurantViewControllerTableViewCell
        if(restaurantArray.count != 0){
            cell.restaurantName.text = restaurantArray[indexPath.row].name
            
            let url = URL(string: restaurantArray[indexPath.row].thumb!)
            let data = try! Data(contentsOf: url!)
            cell.restaurantImg.image = UIImage(data: data)
            
            cell.restaurantLocation.text = restaurantArray[indexPath.row].location
            cell.rating.text = restaurantArray[indexPath.row].rating
            cell.rating.backgroundColor = RestaurantViewController.transferStringToColor(restaurantArray[indexPath.row].rating_color)
            cell.cuisines.text = restaurantArray[indexPath.row].cuisines
        }
        
        //        let img = cell.viewWithTag(1000) as! UIImageView
        //        let name = cell.viewWithTag(1001) as! UILabel
        //        img.image = UIImage(named: restaurants[indexPath.row] + ".jpeg")
        //        name.text = restaurants[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyborad.instantiateViewController(withIdentifier: "RestaurantDetail") as! RestaurantDetailViewController
        
        dvc.getRestaurantName = restaurantArray[indexPath.row].name
        dvc.getCuisines = restaurantArray[indexPath.row].cuisines
        dvc.getRating = restaurantArray[indexPath.row].rating
        dvc.getRatingColor = restaurantArray[indexPath.row].rating_color
        dvc.getRestaurantId = restaurantArray[indexPath.row].id
        dvc.getLocation = restaurantArray[indexPath.row].location
        dvc.getMenu = restaurantArray[indexPath.row].menu!
        dvc.getRestaurantImg = restaurantArray[indexPath.row].thumb!
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        
        // set core location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
            print("Start getting location!!!!!!!!!!!!!!!!!!")
        }
        
        // let findLocation = BASE_URL + CITY + "&" + CITY_COUNT
        let fetchData = BASE_URL + GEO_CODE + LATITUDE + "&" + LONGITUDE
        
        // fetch data from api
        if let url = URL(string: fetchData){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(API_KEY, forHTTPHeaderField: "user_key")
            initialiseTaskForGettingData(request, element: "results")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation:CLLocation = locations.last!
        LONGITUDE = "lon=" + String(currLocation.coordinate.longitude)
        LATITUDE = "lat=" + String(currLocation.coordinate.latitude)
        print("\(LONGITUDE)")
        print("\(LATITUDE)")
    }
    
    func initialiseTaskForGettingData(_ request: URLRequest, element:String){
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error == nil {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            //print(json)
                            if let nearbyRestaurants = json["nearby_restaurants"] as? [NSDictionary]{
                                //print(nearbyRestaurants)
                                self.sizeOfRestaurants = nearbyRestaurants.count;
                                
                                for each in nearbyRestaurants {
                                    let res = each["restaurant"] as! NSDictionary
                                    let location = res["location"] as? NSDictionary
                                    let user_rating = res["user_rating"] as! NSDictionary
                                
                                    let id = res["id"] as! String;
                                    let costForTwo = res["average_cost_for_two"] as! Double;
                                    let name = res["name"] as! String;
                                    let thumb = res["thumb"] as! String;
                                    let address = location!["address"] as! String;
                                    let cuisines = res["cuisines"] as! String;
                                    let menu_url = res["menu_url"] as! String;
                                    let rating = user_rating["aggregate_rating"] as! String;
                                    let rating_color = user_rating["rating_color"] as! String;
                                    
                                    // print(id, costForTwo, name, thumb, address, cuisines, menu_url, rating, rating_color);
                                    self.restaurantArray.append(Restaurant(id: id, name: name, location: address, menu: menu_url, review: [""], thumb: thumb, costForTwo: costForTwo, cuisines: cuisines, rating: rating, rating_color: rating_color));
                                    
                                }
                                DispatchQueue.main.async {
                                    self.tableView.reloadData();
                                }
                            }
                        }
                    } catch {
                    print(error)
                }
            }
        }
    })
    task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let bookmarkController:RestaurantBookmarkTableViewController = segue.destination as! RestaurantBookmarkTableViewController
//
//        if segue.identifier == "bookmark" {
//            if let selectedRow = tableView.indexPathForSelectedRow {
//                let restaurant = bookmarkDb[selectedRow.item]
//                bookmarkController.currentRestaurant = restaurant
//                
//            }
//        }
//    }
    
    public static func transferStringToColor(_ colorStr:String) -> UIColor {
        
        var color = UIColor.red
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = String(cStr[index...])
        }
        if cStr.count != 6 {
            return UIColor.black
        }
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = String(cStr[rRange])
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = String(cStr[gRange])
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
        return color
    }


    
    
    
}

