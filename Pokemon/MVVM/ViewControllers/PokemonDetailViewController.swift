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
    
    
    //MARK: -IBAction
    @IBAction func closeView(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    
    //MARK: -Properties
    private let pokemonDetailViewModel = PokemonDetailViewModel()
    var imagePower: UIImage?
    var imagePowerTWo: UIImage?
    var imagePokemon: UIImage?
    var namePowerOne: String?
    var namePowerTwo: String?
    var namePokemon: String?
    var idPokemon: Int?
    var moves: [String]?
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
        pokemonDetailViewModel.input.idPokemon.accept(idPokemon!)
        pokemonDetailViewModel.output.descriptionPokemons.subscribe(
            onNext:{ description in
                if description != nil {
                    self.pokemonDescriptionText.text = description
                }
            }).disposed(by: disposeBag)
    }

    
    func septupUI() {
        self.pokemonImageView.image = imagePokemon
        self.pekemoNameLabel.text = namePokemon
        self.powerOneLabel.text = namePowerOne
        self.powerOneImage.image = imagePower
        
        guard imagePowerTWo != nil else {
            powerTwoView.isHidden = true
            return
        }
        self.powerTwoImage.image = imagePowerTWo
        self.powerTwoLabel.text = namePowerTwo
    }
    
    func changeColorStoryBoard(){
        imagesPowerPokemon = ImagesForPokemons()
        
        guard namePowerTwo != nil else {
            let color = imagesPowerPokemon.getColorForPower(namePower: namePowerOne!)
            self.frontViewPokemon.backgroundColor = color
            self.frontViewPokemon.backgroundColor?.withAlphaComponent(0.9)
            self.powerOneLabel.textColor = color
            return
            
        }
        
        let color = imagesPowerPokemon.getColorForPower(namePower: namePowerOne!)
        self.frontViewPokemon.backgroundColor? = color
        self.frontViewPokemon.backgroundColor?.withAlphaComponent(0.9)
        self.powerOneLabel.textColor = color
        self.powerTwoLabel.textColor = imagesPowerPokemon.getColorForPower(namePower: namePowerTwo!)
    }

}
