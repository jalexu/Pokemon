//
//  PokemonResponse.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation

struct PokemonResponse: Codable {
    var imageURLPokemon: String?
    var height: Int?
    var weight: Int?
    var name: String?
    var id: Int?
    var sprites: Sprites?
    var moves: [Move]?
    var types: [Type]?
    var abilities: [Ability]?
}
