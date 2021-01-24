//
//  PokemonListApiRepositoryBehavior.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import RxSwift

protocol PokemonListApiRepositoryBehavior {
    func getListOfPokemonForGeneration(idGeneration: Int) throws -> Observable<GenerationResponse>
    func getPokemon(name: String) throws -> Observable<PokemonResponse>
}
