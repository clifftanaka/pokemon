//
//  ViewController.swift
//  Pokemon
//
//  Created by Cliff Tanaka on 2017/03/22.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to go!")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //Spawn new Pokemon
                if let coord = self.manager.location?.coordinate {
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    let randLat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    let randLon = (Double(arc4random_uniform(200)) - 100.0) / 50000.0

                    anno.coordinate.latitude += randLat
                    anno.coordinate.longitude += randLon
                
                    self.mapView.addAnnotation(anno)
                }
            })
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 6 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 400, 400)
            
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, 400, 400)
            mapView.setRegion(region, animated: true)
        }
    }
}

