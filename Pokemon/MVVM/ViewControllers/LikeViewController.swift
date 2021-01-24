//
//  LikeViewController.swift
//  Pokemon
//
//  Created by Jaime Uribe on 24/01/21.
//

import UIKit
import NotificationBannerSwift

class LikeViewController: BaseViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var powerOneLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    //MARK: -IBAction
    @IBAction func returnButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if pokemon.count > 0 {
            pokemon.removeFirst()
            setupUI()
        } else {
            NotificationBanner(title: "Don't have more pokemons for to see.", subtitle: "List is empty", style: .warning).show()
        }
        
    }
    
    @IBAction func dislikeAButtonAction(_ sender: Any) {
        if pokemon.count > 0 {
            pokemon.removeFirst()
            setupUI()
        } else {
            NotificationBanner(title: "Don't have more pokemons for to see.", subtitle: "List is empty", style: .warning).show()
        }
    }
    
    
    //MARK: -Propeeties
    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI(){
        
        pokemonImageView.image = pokemon[0].imagePokemon
        pokemonNameLabel.text = pokemon[0].name
        powerOneLabel.text = pokemon[0].powerName
    }
    

}
