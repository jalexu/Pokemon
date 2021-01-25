//
//  LikeViewController.swift
//  Pokemon
//
//  Created by Jaime Uribe on 24/01/21.
//

import UIKit
import NotificationBannerSwift
import CoreData

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
            setupUI()
            savePokemon(savePokemon: pokemon[0]) { (response) in
                switch response{
                case .success:
                    NotificationBanner(title: "Your pokemon has been save", subtitle: "Succelful", style: .success).show()
                case .failure:
                    NotificationBanner(title: "We can´t save your pokemon", subtitle: "Warning", style: .warning).show()
                }
            }
            pokemon.removeFirst()
        } else {
            NotificationBanner(title: "Don't have more pokemons for to see.", subtitle: "List is empty", style: .warning).show()
        }
        
    }
    
    @IBAction func dislikeAButtonAction(_ sender: Any) {
        if pokemon.count > 0 {
            setupUI()
            pokemon.removeFirst()
        } else {
            NotificationBanner(title: "Don't have more pokemons for to see.", subtitle: "List is empty", style: .warning).show()
        }
    }
    
    
    //MARK: -Propeeties
    var pokemon = [Pokemon]()
    private  var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let manager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPokemon { (response) in
            switch response{
            case .success:
                print("Succes get data")
            case .failure:
                NotificationBanner(title: "Don't have more pokemons for to see.", subtitle: "Warnin", style: .warning).show()
            }
        }
    }
    
    
    func setupUI(){
        
        pokemonImageView.image = pokemon[0].imagePokemon
        pokemonNameLabel.text = pokemon[0].name
        powerOneLabel.text = pokemon[0].powerName
    }
    
    private func savePokemon(savePokemon: Pokemon, completion: @escaping(Result<Bool,Error>) -> ()) {
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: context!)!
        let task = NSManagedObject(entity: entity, insertInto: context)
        task.setValue(Int64(savePokemon.id!), forKey: "id")
        task.setValue(savePokemon.name, forKey: "name")
        task.setValue(savePokemon.powerName, forKey: "namePowerOne")
        task.setValue(savePokemon.imageURL, forKey: "urlImage")
        
        
        do {
            try context?.save()
            print("We have been save your pokemon")
            completion(.success(true))
        } catch {
            completion(.failure(error))
          print("Error with data — \(error)")
        }
    }
    
    private func fetchPokemon(completion: @escaping(Result<[NSManagedObject],Error>) -> ()) {
        
        let context = appDelegate?.persistentContainer.viewContext
        let fechtResponse = NSFetchRequest<NSManagedObject>(entityName: "PokemonEntity")
        
        do {
            let response = try context?.fetch(fechtResponse)
            completion(.success(response!))
        } catch {
            completion(.failure(error))
          print("Error with get data — \(error)")
            
        }
    }
    

}
