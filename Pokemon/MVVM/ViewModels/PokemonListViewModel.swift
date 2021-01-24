//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class PokemonListViewModel: ViewModelProtocol {
    
    //MARK: -Properties
    let disposeBag = DisposeBag()
    var pokemonBLBehavior: PokemonListBLBehavior
    var imagesPowerPokemon: ProtocolImagesForPokemons
    var pokemon = Pokemon()
    var listPokemons: [Pokemon] = []
    var finishProcessOfApi = false
    
    
    let input : Input
    var output : Output
    
    //MARK: -Input and Output
    struct Input {
        var namesPokemons = BehaviorRelay<[String]>(value: [])
        
    }
    
    struct Output{
        var listPokemonsGeneration = BehaviorRelay<[Pokemon]>(value: [])
    }
    
    init() {
        input = Input()
        output = Output()
        pokemonBLBehavior = PokemonListBL(repository: PokemonApiRepository())
        imagesPowerPokemon = ImagesForPokemons()
        callListOfPokemonGenetation()
        bin()
    }
    
    func bin() {
        input.namesPokemons.subscribe(
            onNext: { namesPokemon in
                self.finishProcessOfApi = false
                guard !namesPokemon.isEmpty else { return }
                
                for name in namesPokemon{
                    self.getPokemon(nameOfPokemon: name)
                }
                
                self.finishProcessOfApi = true
                
            }).disposed(by: disposeBag)
    }
    
    
    func callListOfPokemonGenetation(){
        
        do {
            try pokemonBLBehavior.getListOfPokemonForGeneration(idGeneration: 1).asObservable().retry(1).subscribe(
                onNext: { response in
                    var namesOfPokemons = [String]()
                    
                    //Get to list of pokemon for generation
                    response.pokemon_species?.forEach({ name in
                        namesOfPokemons.append(name.name ?? "")
                    })
                    
                    self.input.namesPokemons.accept(namesOfPokemons)
                }, onError: { reponseError in
                    print("Error")
                }).disposed(by: disposeBag)
        }catch {
            print ("Error")
        }
    }
    
    private func getPokemon(nameOfPokemon name: String) {
        do {
            try pokemonBLBehavior.getPokemon(name: name).asObservable().retry(1).subscribe(
                onNext: { response in
                    self.storePokemon(pokemon: response)
                }, onError: { reponseError in
                    print("Error")
                }).disposed(by: disposeBag)
        }catch {
            print ("Error")
        }
    }
    
    
    private func storePokemon(pokemon: PokemonResponse){
        
        var varPokemon = pokemon
        
        self.pokemon.id = pokemon.id
        self.pokemon.name = pokemon.name
        self.pokemon.powerName = pokemon.types![0].type!.name!
        self.pokemon.powerNameTwo = nil
        self.pokemon.imagePokemon = UIImage(data: self.imagesPowerPokemon.setImage(pokemon.sprites!.front_default!))
        self.pokemon.powerOne = self.imagesPowerPokemon.setImageOfPowers(typePower: pokemon.types![0].type!.name!)
        self.pokemon.powerTwo = nil
        if pokemon.types!.count == 2 {
            self.pokemon.powerTwo = self.imagesPowerPokemon.setImageOfPowers(typePower: pokemon.types![1].type!.name!)
            self.pokemon.powerNameTwo = pokemon.types![1].type!.name!
        }
        
        var string = [String]()
        
        if varPokemon.moves!.count > 5 {
            for _ in 1..<5{
                
                if let a = varPokemon.moves?.last {
                    string.append((a.move?.name)!)
                varPokemon.moves?.removeLast()
                }
            }
            
            self.pokemon.moves = string
            
        } else {
           
        }
        
        
        
        
        self.listPokemons.append(self.pokemon)
        
        if finishProcessOfApi {
            self.output.listPokemonsGeneration.accept(listPokemons)
        }
    }
    
    
}

