//
//  Pokemon.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import UIKit

struct Pokemon {
    var imagePokemon: UIImage?
    var powerName: String?
    var powerNameTwo: String?
    var name: String?
    var id: Int?
    var powerOne: UIImage?
    var powerTwo: UIImage?
    var moves: [String]?
    var abilities: [String]?
}

struct PokemonDescription {
    var pokemonDescription: DescriptionPokemonResponse?
}
