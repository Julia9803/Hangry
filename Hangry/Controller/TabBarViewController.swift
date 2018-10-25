//
//  TabBarViewController.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/9/16.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.creatSubViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func creatSubViewControllers(){
//        let firstVC = FirstViewController()
//        firstVC.title = "Home"
//        let navi0 = UINavigationController(rootViewController:firstVC)
//        navi0.tabBarItem.title = "Home"
//        navi0.tabBarItem.image = UIImage (named:"home-1")
//        navi0.tabBarItem.selectedImage = UIImage(named:"home-2")
//
//        let secondVC = RestaurantViewController()
//        secondVC.title = "Restaurant"
//        let navi1 = UINavigationController(rootViewController:secondVC)
//        navi1.tabBarItem.title = "Restaurant"
//        navi1.tabBarItem.image = UIImage (named:"restaurant-1")
//        navi1.tabBarItem.selectedImage = UIImage(named:"restaurant-2")
//
//
//        //tabBar.tintColor = UIColor.orange
//        let tabArray = [navi0,navi1]
//        self.viewControllers = tabArray
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
