//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Cliff Tanaka on 2017/03/28.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    
    var  coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
}
