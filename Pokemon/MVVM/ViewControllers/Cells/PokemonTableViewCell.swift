//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    //MARK: -IBOutlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var powerOneImageView: UIImageView!
    @IBOutlet weak var poweTwoImageView: UIImageView!
    @IBOutlet weak var namePokemonLabel: UILabel!
    @IBOutlet weak var idPokemonLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func septupCellWiht(pokemon: Pokemon) {
        pokemonImageView.image = pokemon.imagePokemon
        namePokemonLabel.text = pokemon.name
        idPokemonLabel.text = (String(describing: pokemon.id!))
        powerOneImageView.image = pokemon.powerOne
        poweTwoImageView.image = nil
        if pokemon.powerTwo != nil {
            poweTwoImageView.image = pokemon.powerTwo
        }
    }
    
}
