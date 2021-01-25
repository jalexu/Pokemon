//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Jaime Uribe on 24/01/21.
//

import RxSwift
import XCTest

enum errorBLPokemon : Error {
    case errorResponse
}

class PokemonBLFake: PokemonListBLBehavior {
    func getListOfPokemonForGeneration(nameGeneration: String, numberPage: Int, numberOfPokemons: Int) throws -> Observable<GenerationResponse> {
        var response = GenerationResponse()
        response.id = 1
        response.name = "Generation VI"
        response.names = [NameFromGeneration(name: "skype")]
        response.pokemon_species = [GeneralResponse(name: "bunnelby", url: "https://pokeapi.co/api/v2/pokemon-species/659/"),
        GeneralResponse(name: "honedge", url: "https://pokeapi.co/api/v2/pokemon-species/679/")]
        return Observable<GenerationResponse>.just(response)
        
    }
    
    func getPokemon(name: String) throws -> Observable<PokemonResponse> {
        var response = PokemonResponse()
        response.imageURLPokemon = nil
        response.height = 4
        response.weight = 95
        response.name = "fennekin"
        response.sprites = Sprites(back_default: nil,
                                   back_female: nil,
                                   back_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/653.png",
                                   back_shiny_female: nil,
                                   front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/653.png",
                                   front_female: nil,
                                   front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/653.png",
                                   front_shiny_female: nil)
        response.moves = [Move(move: GeneralResponse(name: "ember", url: "https://pokeapi.co/api/v2/move/510/")), Move(move: GeneralResponse(name: "round", url: "https://pokeapi.co/api/v2/move/496"))]
        response.types = [Type(slot: 1, type: GeneralResponse(name: "fire", url: "https://pokeapi.co/api/v2/type/10/"))]
        response.abilities = [Ability(ability: GeneralResponse(name: "magician", url: "https://pokeapi.co/api/v2/ability/170/"))]
        
        return Observable<PokemonResponse>.just(response)
        
    }
    
    func getPoKemonDescription(idPokemon: Int) throws -> Observable<DescriptionPokemonResponse> {
        var response = DescriptionPokemonResponse()
        response.base_happiness = 70
        response.capture_rate = 45
        response.flavor_text_entries = [FloverText(flavor_text: "Wenn es seine Kraft auf die sonst eher weichen\nStacheln auf seinem Kopf konzentriert, werden\ndiese robust genug, um damit Steine zu zertrümmern.", language: GeneralResponse(name: "de", url: "https://pokeapi.co/api/v2/language/6/")),
                                        FloverText(flavor_text: "The quills on its head are usually soft.\nWhen it flexes them, the points become\nso hard and sharp that they can pierce rock.", language: GeneralResponse(name: "en", url: "https://pokeapi.co/api/v2/language/9/"))]
        
        return Observable<DescriptionPokemonResponse>.just(response)
    }
    
    
}

class PokemonBLFakeWhitError: PokemonListBLBehavior {
    func getListOfPokemonForGeneration(nameGeneration: String, numberPage: Int, numberOfPokemons: Int) throws -> Observable<GenerationResponse> {
        return Observable.error(createError())
    }
    
    func getPokemon(name: String) throws -> Observable<PokemonResponse> {
        return Observable.error(errorBLPokemon.errorResponse)
    }
    
    func getPoKemonDescription(idPokemon: Int) throws -> Observable<DescriptionPokemonResponse> {
        return Observable.error(createError())
    }
    
    
    func createError() -> Error {
        let error =  NSError(domain: "NSError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Response status code was unacceptable: 401., NSUnderlyingError=0x2831b1d80 {Error Domain=Alamofire.AFError Code=3"])
        return error
    }
}

class PokemonTests: XCTestCase {
    
    
    var viewModel: PokemonListViewModel!
    var disposebag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        self.disposebag = DisposeBag()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetListOfPokemonsForGeneration(){
        
        let fakeBL = PokemonBLFake()
        viewModel = PokemonListViewModel.init(pokemonBL: fakeBL)
        viewModel.input.nameGeneration.accept(("generation-v", 10, 10))
        
        XCTAssertFalse(viewModel.input.namesPokemons.value.isEmpty)
    }
    
    func testGetPokemonWhenListIsEmpty() {
        let pokemonList = [String]()
        let fakeBL = PokemonBLFake()
        viewModel = PokemonListViewModel.init(pokemonBL: fakeBL)
        viewModel.input.namesPokemons.accept(pokemonList)
        
        XCTAssertTrue(viewModel.output.listPokemonsGeneration.value.isEmpty)
        
    }
    
    func testGetDescriptionPokemon(){
        
        let fakeBL = PokemonBLFake()
        let viewModelTwo = PokemonDetailViewModel(pokemonDetailBL: fakeBL)
        
        viewModelTwo.input.idPokemon.accept(45)
        
        XCTAssert(!viewModelTwo.output.descriptionPokemons.value!.isEmpty, "Show description of pokemon")
        
    }
    
    
    func testGetListOfPokemonsForGenerationServicesResposeError(){
        
        let fakeBL = PokemonBLFakeWhitError()
        viewModel = PokemonListViewModel.init(pokemonBL: fakeBL)
        viewModel.input.nameGeneration.accept(("generation-v", 10, 10))
        
        XCTAssert(viewModel.output.isError.value, "Show Error in view")
    }
    
    func testGetPokemonWhenListServicesResposeError() {
        let pokemonList = [String]()
        let fakeBL = PokemonBLFake()
        viewModel = PokemonListViewModel.init(pokemonBL: fakeBL)
        viewModel.input.namesPokemons.accept(pokemonList)
        
        XCTAssertTrue(viewModel.output.listPokemonsGeneration.value.isEmpty)
        
    }
    
    func testGetDescriptionPokemonServicesResposeError(){
        
        let fakeBL = PokemonBLFake()
        let viewModelTwo = PokemonDetailViewModel(pokemonDetailBL: fakeBL)
        
        viewModelTwo.input.idPokemon.accept(45)
        
        XCTAssert(!viewModelTwo.output.isError.value, "Show Error in view")
        
    }
    
    

}
