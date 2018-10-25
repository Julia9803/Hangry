//
//  RestaurantDetailViewController.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/16.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var bookmarkModel:ResutaurantBookmarkCDModel = ResutaurantBookmarkCDModel.sharedInstance
    var reviewModel:RestaurantReviewCDModel = RestaurantReviewCDModel.sharedInstance
    var currentBookmark:RestaurantBookmarkCD?

    let BASE_URL:String = "https://developers.zomato.com/api/v2.1/"
    let API_KEY:String = "6c1d4d9b6d74ca97218eb59883f8c3ed"
    let REVIEWS:String = "reviews?"
    var RES_ID:String = "res_id="
    var sizeOfReviews:Int = 5
    var reviewList: [RestaurantReview] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sizeOfReviews;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! RestaurantReviewTableViewCell
        if(reviewList.count != 0){
            detailCell.username.text = reviewList[indexPath.row].username;
            detailCell.reviewText.text = reviewList[indexPath.row].review_text;
            detailCell.reviewTime.text = reviewList[indexPath.row].time;
            detailCell.userLevel.text = String(reviewList[indexPath.row].user_level);
            detailCell.rating.text = String(reviewList[indexPath.row].rating);
        
            let url = URL(string: reviewList[indexPath.row].avatar)
            let data = try! Data(contentsOf: url!)
            detailCell.userAvatar.image = UIImage(data: data);
        }
        
        return detailCell;
    }
    
    
    var getRestaurantImg = String()
    var getRestaurantId = String()
    var getRestaurantName = String()
    var getLocation = String()
    var getCuisines = String()
    var getRating = String()
    var getRatingColor = String()
    var getMenu = String()
    
    
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantDetail: UILabel!
    @IBOutlet weak var restaurantReview: UIImageView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var restaurantBookmark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add eventlistener to restaurant review
        let reviewTapGesture = UITapGestureRecognizer(target: self, action: #selector(addRestaurantReview))
        restaurantReview?.addGestureRecognizer(reviewTapGesture)
        restaurantReview?.isUserInteractionEnabled = true
        
        // add eventlistener to restaurant bookmark
        let bookmarkTapGesture = UITapGestureRecognizer(target: self, action: #selector(addRestaurantBookmark))
        restaurantBookmark?.addGestureRecognizer(bookmarkTapGesture)
        restaurantBookmark?.isUserInteractionEnabled = true
        
        // fetch review data load
        self.reviewTableView.rowHeight = 203;
        
        let url = URL(string: getRestaurantImg)
        let data = try! Data(contentsOf: url!)
        self.restaurantImg.image = UIImage(data: data)
        
        self.restaurantLocation.text = getLocation
        self.restaurantName.text = getRestaurantName
        self.restaurantDetail.text = getCuisines
        self.restaurantRating.text = getRating
        self.restaurantRating.backgroundColor = RestaurantViewController.transferStringToColor(getRatingColor)
        
        RES_ID.append(getRestaurantId)
        let fetchReview:String = BASE_URL + REVIEWS + RES_ID
        fetchData(url: fetchReview)
        
        // init currentBookmark
        currentBookmark?.restaurant_id = getRestaurantId
        currentBookmark?.restaurant_name = getRestaurantName
        currentBookmark?.thumb = getRestaurantImg
        currentBookmark?.location = getLocation
        currentBookmark?.rating = getRating
        currentBookmark?.rating_color = getRatingColor
        currentBookmark?.cuisines = getCuisines
        
        // check bookmark exist
        let exist = bookmarkModel.checkExist(restaurantId: getRestaurantId)
        if exist {
            restaurantBookmark.image = #imageLiteral(resourceName: "bookmark-2")
        }else {
            restaurantBookmark.image = #imageLiteral(resourceName: "bookmark-1")
        }
    }
    
    func fetchData(url: String) {
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(API_KEY, forHTTPHeaderField: "user_key")
            
            initialiseTaskForGettingData(request, element: "results")
        }
    }
    
    func initialiseTaskForGettingData(_ request: URLRequest, element:String){
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error == nil {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            // print(json)
                            
                            self.sizeOfReviews = json["reviews_shown"] as! Int;
                            // print(size)
                            
                            if let user_reviews = json["user_reviews"] as? [NSDictionary]{
                                  // print(user_reviews)
                                
                                for each in user_reviews {
                                    // print(each)
                                    let review = each["review"] as! NSDictionary
                                    let user = review["user"] as! NSDictionary
                                    
                                    let rating = review["rating"] as! Int
                                    let rating_color = review["rating_color"] as! String
                                    let review_text = review["review_text"] as! String
                                    let time = review["review_time_friendly"] as! String
                                    let username = user["name"] as! String
                                    let user_level = user["foodie_level_num"] as! Int
                                    let avatar = user["profile_image"] as! String
                                    
                                    // print(rating, rating_color, review_text, time, username, user_level, avatar)
                                    self.reviewList.append(RestaurantReview(rating: rating, review_text: review_text, time: time, username: username, user_level: user_level, avatar: avatar))
                                }
                                DispatchQueue.main.async {
                                    self.reviewTableView.reloadData();
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
    

    @objc public func addRestaurantBookmark() {
        if restaurantBookmark.image == #imageLiteral(resourceName: "bookmark-1") {
            restaurantBookmark.image = restaurantBookmark.highlightedImage
            
            bookmarkModel.saveRestaurantBookmarkCD(getRestaurantId, restaurant_name: getRestaurantName, location: getLocation, rating: getRating, rating_color: getRatingColor, thumb: getRestaurantImg, cuisines: getCuisines, existing: currentBookmark)
            
        }else {
            restaurantBookmark.image = #imageLiteral(resourceName: "bookmark-1")
            bookmarkModel.easyDeleteRestaurantBookmarkCD(restaurantId: getRestaurantId)
        }
    }
    
    @objc public func addRestaurantReview() {
        
    }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bookmarkController:RestaurantBookmarkTableViewController = segue.destination as! RestaurantBookmarkTableViewController
        if segue.identifier == "bookmark" {
            if let selectedRow
        }
    }
*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mapViewController:MapViewController = segue.destination as! MapViewController
    
        if segue.identifier == "mapView" {
            mapViewController.address = getLocation
            mapViewController.restaurantName = getRestaurantName
        }
    }
}
