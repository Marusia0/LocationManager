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
    var myLocation = Location(0,0,0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavi()
        initMap()
    }
}

// MARK: - Navigation

extension ViewController {
    func initNavi() {
        // sets up navigation
        title = "My Location"
        navigationController?.navigationBar.barTintColor = UIColor(
            red:0.082, green:0.443, blue:0.737, alpha:1.000
        )
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
}

// MARK: - Map & Location

extension ViewController {
    func initMap() {
        // sets up map & location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        myMap.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get current location after updates
        let location = locations[0]
        let span = MKCoordinateSpanMake(1.0, 1.0)
        let userLocation = CLLocationCoordinate2DMake(
            location.coordinate.latitude, location.coordinate.longitude
        )
        let region = MKCoordinateRegionMake(userLocation, span)
        myMap.setRegion(region, animated: true)
        myMap.userLocation.title = "Info"
        myMap.userLocation.subtitle = " 👇 "
        
        // sets up updated location
        myLocation.longitude = userLocation.longitude
        myLocation.latitude = userLocation.latitude
        myLocation.altitude = location.altitude
        myLocation.speed = location.speed
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // add tap gesture to the annotation
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(tappedAnnotation)
        )
        view.addGestureRecognizer(tap)
    }
    
    func tappedAnnotation() {
        // remove annotation
        guard let annotation = myMap.selectedAnnotations.first else { return }
        myMap.deselectAnnotation(annotation, animated: true)
        
        // show dialog for location info
        let msg = "Longitude: \(myLocation.longitude)\n" +
                  "Latitude: \(myLocation.latitude)\n" +
                  "Altitude: \(myLocation.altitude)\n" +
                  "Speed: \(myLocation.speed)"
        
        let alert = UIAlertController(
            title: nil,
            message: msg,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) {action in
            self.myMap.deselectAnnotation(annotation, animated: true)
        })
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Location

class Location {
    var longitude, latitude, altitude, speed: Double
    init(_ longitude: Double, _ latitude: Double, _ altitude: Double, _ speed: Double) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
        self.speed = speed
    }
}
