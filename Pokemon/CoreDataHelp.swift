//
//  CoreDataHelp.swift
//  Pokemon
//
//  Created by Cliff Tanaka on 2017/03/28.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon() {
    
    createPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    createPokemon(name: "Charmander", imageName: "charmander")
    createPokemon(name: "Dratini", imageName: "dratini")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Jigglypuff", imageName: "jigglypuff")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Pikachu", imageName: "pikachu")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Rattata", imageName: "rattata")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func createPokemon(name: String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
}
