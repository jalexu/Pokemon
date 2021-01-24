//
//  PokemonApi.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import Moya


public enum PokemonApi {
    case getListPokemonGenerations(id: Int)
    case getPokemon(name: String)
}

extension PokemonApi: TargetType{
    public var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    public var path: String {
        switch self {
        case .getListPokemonGenerations(let id):
            return URLsOperationServices.getListOfPokemonGenerations.description + "\(id)"
        case .getPokemon(let name):
            return URLsOperationServices.getPokemon.description + "\(name)"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getListPokemonGenerations:
            return .get
        case .getPokemon:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getListPokemonGenerations:
            return Data()
        case .getPokemon:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .getListPokemonGenerations:
            return .requestPlain
        case .getPokemon:
            return .requestPlain
//        case .getListPokemons(let numberMinOfPokemons, let numberMaxOfPokemon):
//            return .requestParameters(parameters: ["offset": numberMinOfPokemons,
//                                                   "limit": numberMaxOfPokemon], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .customCodes([200, 404, 500])
    }
    
    
}
