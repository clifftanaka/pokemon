//
//  ViewController.swift
//  Pokemon
//
//  Created by Cliff Tanaka on 2017/03/22.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    var pokemons : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            mapView.delegate = self
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //Spawn new Pokemon
                if let coord = self.manager.location?.coordinate {
                    
                    let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                    
                    let anno = PokeAnnotation(coord: coord, pokemon: pokemon)
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        
        
        if annotation is MKUserLocation {
            annoView.image = UIImage(named: "player")
        } else {
            let pokemon = (annotation as! PokeAnnotation).pokemon
            annoView.image = UIImage(named: pokemon.imageName!)
        }
        
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        
        return annoView
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 6 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 300, 300)
            
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation is MKUserLocation {
            return
        }
        
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 300, 300)
        
        mapView.setRegion(region, animated: false)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
            if let coord = self.manager.location?.coordinate {
                if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coord)) {
                    print("can catch")
                    
                    let pokemon = (view.annotation as! PokeAnnotation).pokemon
                    pokemon.caught = true
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                } else {
                    print("pokemon is too far away")
                }
            }
        })
        
        
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, 300, 300)
            mapView.setRegion(region, animated: true)
        }
    }
}

