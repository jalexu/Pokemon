//
//  PokemonApiRepository.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class PokemonApiRepository: PokemonListApiRepositoryBehavior  {
    
    let pokemonApi = MoyaProvider<PokemonApi>()
    
    func getListOfPokemonForGeneration(idGeneration: Int) throws -> Observable<GenerationResponse> {
        return pokemonApi.rx.request(PokemonApi.getListPokemonGenerations(id: idGeneration)).asObservable()
            .flatMap({ response -> Observable<GenerationResponse> in
                
                if response.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(GenerationResponse.self, from: response.data)
                    return Observable.just(result)
                }else {
                    let error = NSError(domain: "Error Pokemon List Generation", code: response.statusCode, userInfo: ["Error": response.description])
                    return Observable.error(error)
                }
        })
    }
    
    func getPokemon(name: String) throws -> Observable<PokemonResponse>{
        return pokemonApi.rx.request(PokemonApi.getPokemon(name: name)).asObservable().asObservable()
            .flatMap({ response -> Observable<PokemonResponse> in
                
                if response.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PokemonResponse.self, from: response.data)
                    return Observable.just(result)
                }else {
                    let error = NSError(domain: "Error get pokemon", code: response.statusCode, userInfo: ["Error": response.description])
                    return Observable.error(error)
                }
            
        })
    }
}

