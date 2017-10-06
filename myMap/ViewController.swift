//
//  ViewController.swift
//  myMap
//
//  Created by Marusia Ochoa Ramírez on 2/10/17.
//  Copyright © 2017 Marusia Ochoa Ramírez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(1.0, 1.0)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        
        myMap.setRegion(region, animated: true)

        print(location.altitude)
        print(location.speed)
        
        self.myMap.showsUserLocation = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let mark : MKPointAnnotation = MKPointAnnotation()
        //mark.coordinate = location
        mark.title = "Info"
        mark.subtitle = "click here"
        myMap.addAnnotation(mark)
    }
}

