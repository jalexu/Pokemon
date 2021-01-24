//
//  PokemonListBLBehavior.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import RxSwift

protocol PokemonListBLBehavior {
    func getListOfPokemonForGeneration(idGeneration: Int) throws -> Observable<GenerationResponse>
    func getPokemon(name: String) throws -> Observable<PokemonResponse>
    func getPoKemonDescription(idPokemon: Int) throws -> Observable<DescriptionPokemonResponse>
}
