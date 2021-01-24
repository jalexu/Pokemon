//
//  ViewController.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class PokemonListViewController: BaseViewController{
    
    
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private let pokemonListViewModel = PokemonListViewModel()
    private let cellId = "PokemonTableViewCell"
    private var dataSource = [Pokemon]()
    private var pokemonIndexSelect = Pokemon()

    override func viewDidLoad() {
        super.viewDidLoad()
        septupUI()
        bind()
    }
    
    private func septupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
    }
    
    func bind(){
        
        pokemonListViewModel.output.listPokemonsGeneration.subscribe(
            onNext: { listPokemons in
                if !listPokemons.isEmpty {
                    self.dataSource = listPokemons
                    self.tableView.reloadData()
                }
        }).disposed(by: disposeBag)
    }
}


//MARK: - UITableViewDataSource
extension  PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let createCell = cell as? PokemonTableViewCell {
            //se confirufra la celda
            createCell.septupCellWiht(pokemon: dataSource[indexPath.row])
        }
        
        return cell
    }
}


extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pokemonIndexSelect = dataSource[indexPath.row]
        
        performSegue(withIdentifier: "pokemonDetailSegue", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailSegue" {
            let vc = segue.destination as! PokemonDetailViewController
            vc.imagePower = pokemonIndexSelect.powerOne
            vc.imagePokemon = pokemonIndexSelect.imagePokemon
            vc.namePowerOne = pokemonIndexSelect.powerName
            vc.namePokemon = pokemonIndexSelect.name
            vc.idPokemon = pokemonIndexSelect.id
            vc.moves = pokemonIndexSelect.moves
            
            if let namePowerTwo = pokemonIndexSelect.powerNameTwo{
                vc.namePowerTwo = namePowerTwo
            }
            
            if let powerTwo = pokemonIndexSelect.powerTwo{
                vc.imagePowerTWo = powerTwo
            }
        }
    }
    
}
