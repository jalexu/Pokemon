//
//  DescriptionPokemon.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation

struct DescriptionPokemon: Codable {
    var base_happiness: Int?
    var capture_rate: Int?
    var flavor_text_entries: [FloverText]?
    
    init() {}
}

struct FloverText: Codable{
    var flavor_text: String?
    var language: GeneralResponse?
    var version: GeneralResponse?
}
