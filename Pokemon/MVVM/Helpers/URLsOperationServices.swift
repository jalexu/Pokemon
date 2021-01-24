//
//  URLsOperationServices.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation

enum URLsOperationServices: CustomStringConvertible{
    
    case getListOfPokemonGenerations, getPokemon, getPokemonDescription
    
    var description: String{
        switch self {
        case .getListOfPokemonGenerations:
            return "generation/"
        case .getPokemon:
            return "pokemon/"
        case .getPokemonDescription:
            return "pokemon-species/"
        }
    }
}
