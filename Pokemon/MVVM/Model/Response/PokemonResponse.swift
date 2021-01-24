//
//  PokemonResponse.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation

struct PokemonResponse: Codable {
    var imageURLPokemon: String?
    var name: String?
    var id: Int?
    var sprites: Sprites?
    var types: [Type]?
}
