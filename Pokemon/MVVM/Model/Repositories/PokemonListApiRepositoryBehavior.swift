//
//  PokemonListApiRepositoryBehavior.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import RxSwift

protocol PokemonListApiRepositoryBehavior {
    func getListOfPokemonForGeneration(nameGeneration: String, numberPage: Int,numberOfPokemons: Int) throws -> Observable<GenerationResponse>
    func getPokemon(name: String) throws -> Observable<PokemonResponse>
    func getPoKemonDescription(idPokemon: Int) throws -> Observable<DescriptionPokemonResponse>
}
