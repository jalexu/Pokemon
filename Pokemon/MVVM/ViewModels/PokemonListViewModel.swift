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
        var nameGeneration = BehaviorRelay<(String?, Int, Int)>(value: (nil, 1, 20))
        
    }
    
    struct Output{
        var listPokemonsGeneration = BehaviorRelay<[Pokemon]>(value: [])
        var isError = BehaviorRelay<Bool>(value: false)
    }
    
    init() {
        input = Input()
        output = Output()
        pokemonBLBehavior = PokemonListBL(repository: PokemonApiRepository())
        imagesPowerPokemon = ImagesForPokemons()
        bin()
    }
    
    init(pokemonBL: PokemonListBLBehavior) {
        input = Input()
        output = Output()
        pokemonBLBehavior = pokemonBL
        imagesPowerPokemon = ImagesForPokemons()
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
        
        input.nameGeneration.subscribe(
            onNext: { generation in
                if generation.0 != nil {
                    self.listPokemons.removeAll()
                    self.callListOfPokemonGenetation(nameGeneration: generation.0!, numberPage: generation.1, numberOfPokemons: generation.2)
                }
            }).disposed(by: disposeBag)
        
    }
    
    
    func callListOfPokemonGenetation(nameGeneration: String, numberPage: Int, numberOfPokemons: Int){
        
        do {
            try pokemonBLBehavior.getListOfPokemonForGeneration(nameGeneration: nameGeneration, numberPage: numberPage, numberOfPokemons: numberOfPokemons).asObservable().retry(1).subscribe(
                onNext: { response in
                    var namesOfPokemons = [String]()
                    
                    //Get to list of pokemon for generation
                    response.pokemon_species?.forEach({ name in
                        namesOfPokemons.append(name.name ?? "")
                    })
                    
                    self.input.namesPokemons.accept(namesOfPokemons)
                }, onError: { reponseError in
                    self.output.isError.accept(true)
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
        
        self.pokemon.id = pokemon.id
        self.pokemon.name = pokemon.name
        self.pokemon.powerName = pokemon.types![0].type!.name!
        self.pokemon.powerNameTwo = nil
        self.pokemon.imageURL = pokemon.sprites!.front_default!
        self.pokemon.imagePokemon = UIImage(data: self.imagesPowerPokemon.setImage(pokemon.sprites!.front_default!))
        self.pokemon.powerOne = self.imagesPowerPokemon.setImageOfPowers(typePower: pokemon.types![0].type!.name!)
        self.pokemon.powerTwo = nil
        if pokemon.types!.count == 2 {
            self.pokemon.powerTwo = self.imagesPowerPokemon.setImageOfPowers(typePower: pokemon.types![1].type!.name!)
            self.pokemon.powerNameTwo = pokemon.types![1].type!.name!
        }
        self.pokemon.abilities = getAbilitiesForPokemon(abilities: pokemon.abilities!)
        self.pokemon.moves = getMovesForPokemon(moves: pokemon.moves!)
        
        self.listPokemons.append(self.pokemon)
        
        if finishProcessOfApi {
            self.output.listPokemonsGeneration.accept(listPokemons)
        }
    }
    
    private func getMovesForPokemon(moves: [Move]) -> [String]{
        
        var stringMoves = [String]()
        var varMoves = moves
        
        guard moves.count > 5 else {
            for _ in 1...varMoves.count{
                if let pokemonMoves = moves.last {
                    stringMoves.append((pokemonMoves.move?.name)!)
                    varMoves.removeLast()
                }
            }
            return stringMoves
        }
        
        
        for _ in 1...5{
            if let pokemonMoves = moves.last {
                stringMoves.append((pokemonMoves.move?.name)!)
                varMoves.removeLast()
            }
        }
        
        return stringMoves
    }
    
    
    private func getAbilitiesForPokemon(abilities: [Ability]) -> [String]{
        
        var stringAbilities = [String]()
        let varAbilities =  abilities
        
        for ability in varAbilities {
            stringAbilities.append(ability.ability!.name!)
        }
        
        return stringAbilities
    }
    
    
}

