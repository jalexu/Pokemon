//
//  GenerationResponse.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation

struct GenerationResponse: Codable {
    var id: Int?
    var name: String?
    //var abilities: [Ability]?
    var names: [NameFromGeneration]?
    var pokemon_species: [GeneralResponse]?
}
