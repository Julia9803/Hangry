//
//  MapViewController.swift
//  Hangry
//
//  Created by 高毓彬 on 2018/10/1.
//  Copyright © 2018年 RMIT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var name: UILabel!
    
    var address:String = ""
    var restaurantName:String = ""
    fileprivate let locationManager = CLLocationManager()
    fileprivate var previousPoint: CLLocation?
    // How far do you move (in meters) before you receive an update.
    fileprivate var totalMovementDistance = CLLocationDistance(0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = restaurantName
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // how often do you want to receive updates. locationManager.distanceFilter = 50
        // Before your application can use location services, you need to get the user’s permission to do so.
        locationManager.requestWhenInUseAuthorization()
        
        searchForLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchForLocation() {
        // Create a Coordinate Locator
        let geoCoder = CLGeocoder()
        var coords: CLLocationCoordinate2D?
        // Determine the zoom level of the map to display
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        geoCoder.geocodeAddressString (address, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in if let placemark = placemarks?[0] {
            // Convert the address to a coordinate
            let location = placemark.location
            coords = location!.coordinate
            // Set the map to the coordinate
            let region = MKCoordinateRegion (center: coords!, span: span)
            self.mapView.region = region
            // Add a pin to the address location
            self.mapView.addAnnotation( MKPlacemark (placemark: placemark))
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print ( "Authorization status changed to \(status.rawValue) ")
        switch status {
            case .authorizedAlways, .authorizedWhenInUse: locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            default:
                locationManager.stopUpdatingLocation()
                mapView.showsUserLocation = false
        }
    }
}
