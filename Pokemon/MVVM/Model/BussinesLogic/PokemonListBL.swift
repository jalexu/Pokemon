//
//  PokemonListBL.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import RxSwift

class PokemonListBL: PokemonListBLBehavior {
    
    var pokemonListApiRepositoryBejavior: PokemonListApiRepositoryBehavior
    
    init(repository: PokemonListApiRepositoryBehavior ) {
        self.pokemonListApiRepositoryBejavior = repository
    }
    
    func getListOfPokemonForGeneration(idGeneration: Int) throws -> Observable<GenerationResponse> {
        return try pokemonListApiRepositoryBejavior.getListOfPokemonForGeneration(idGeneration: idGeneration).asObservable()
            .flatMap({ response -> Observable<GenerationResponse> in
            return Observable.just(response)
        })
    }
    
    func getPokemon(name: String) throws -> Observable<PokemonResponse> {
        return try pokemonListApiRepositoryBejavior.getPokemon(name: name).asObservable()
            .flatMap({ response -> Observable<PokemonResponse> in
                return Observable.just(response)
        })
    }
    
    func getPoKemonDescription(idPokemon: Int) throws -> Observable<DescriptionPokemonResponse>{
        return try pokemonListApiRepositoryBejavior.getPoKemonDescription(idPokemon: idPokemon).asObservable().flatMap({ reponse -> Observable<DescriptionPokemonResponse> in
            return Observable.just(reponse)
        })
    }
}


