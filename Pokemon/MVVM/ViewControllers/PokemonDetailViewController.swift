//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import UIKit

class PokemonDetailViewController: BaseViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pekemoNameLabel: UILabel!
    @IBOutlet weak var powerTwoView: UIView!
    @IBOutlet weak var powerOneImage: UIImageView!
    @IBOutlet weak var powerTwoImage: UIImageView!
    @IBOutlet weak var powerOneLabel: UILabel!
    @IBOutlet weak var powerTwoLabel: UILabel!
    @IBOutlet weak var pokemonDescriptionText: UITextView!
    @IBOutlet var frontViewPokemon: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    //MARK: -IBAction
    @IBAction func closeView(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    
    //MARK: -Properties
    private let pokemonDetailViewModel = PokemonDetailViewModel()
    var pokemon: Pokemon?
    var imagesPowerPokemon: ProtocolImagesForPokemons!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
        septupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeColorStoryBoard()
        
    }
    
    private func build(){
        pokemonDetailViewModel.input.idPokemon.accept(pokemon!.id!)
        pokemonDetailViewModel.output.descriptionPokemons.subscribe(
            onNext:{ description in
                if description != nil {
                    self.pokemonDescriptionText.text = description
                }
            }).disposed(by: disposeBag)
    }

    
    func septupUI() {
        self.pokemonImageView.image = pokemon!.imagePokemon
        self.pekemoNameLabel.text = pokemon!.name
        self.powerOneLabel.text = pokemon!.powerName
        self.powerOneImage.image = pokemon!.powerOne
        showAbilities()
        showMoves()
        
        guard pokemon?.powerTwo != nil else {
            powerTwoView.isHidden = true
            return
        }
        self.powerTwoImage.image = pokemon!.powerTwo
        self.powerTwoLabel.text = pokemon!.powerNameTwo
    }
    
    func changeColorStoryBoard(){
        imagesPowerPokemon = ImagesForPokemons()
        
        guard pokemon?.powerNameTwo != nil else {
            let color = imagesPowerPokemon.getColorForPower(namePower: pokemon!.powerName!)
            self.frontViewPokemon.backgroundColor = color
            self.frontViewPokemon.backgroundColor?.withAlphaComponent(0.9)
            self.powerOneLabel.textColor = color
            return
            
        }
        
        let color = imagesPowerPokemon.getColorForPower(namePower: pokemon!.powerName!)
        self.frontViewPokemon.backgroundColor? = color
        self.frontViewPokemon.backgroundColor?.withAlphaComponent(0.9)
        self.powerOneLabel.textColor = color
        self.powerTwoLabel.textColor = imagesPowerPokemon.getColorForPower(namePower: pokemon!.powerNameTwo!)
    }
    
    
    private func showAbilities(){
        var strg: String = ""
        for ability in pokemon!.abilities! {
            strg = strg + "\(ability), "
        }
        abilitiesLabel.text = strg
    }
    
    
    private func showMoves(){
        var strg: String = ""
        for moves in pokemon!.moves! {
            strg = strg + "\(moves), "
        }
        movesLabel.text = strg
    }

}
