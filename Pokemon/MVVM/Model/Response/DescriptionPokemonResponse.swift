//
//  DescriptionPokemonResponse.swift
//  Pokemon
//
//  Created by Jaime Uribe on 24/01/21.
//

import Foundation

struct DescriptionPokemonResponse: Codable {
    var base_happiness: Int?
    var capture_rate: Int?
    var flavor_text_entries: [FloverText]?
}

struct FloverText: Codable{
    var flavor_text: String?
    var language: GeneralResponse?
}
