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
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    private let pokemonListViewModel = PokemonListViewModel()
    private let cellId = "PokemonTableViewCell"
    private var dataSource = [Pokemon]()
    private var pokemonIndexSelect = Pokemon()
    private var searchPokemon = [Pokemon]()
    private var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        septupUI()
        bind()
    }
    
    private func septupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        searchBar.delegate = self
        
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
        if searching{
            return searchPokemon.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let createCell = cell as? PokemonTableViewCell {
            //se confirufra la celda
            if searching {
                createCell.septupCellWiht(pokemon: searchPokemon[indexPath.row])
            } else {
                createCell.septupCellWiht(pokemon: dataSource[indexPath.row])
            }
            
        }
        
        return cell
    }
}


//MARK: -UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pokemonIndexSelect = dataSource[indexPath.row]
        
        performSegue(withIdentifier: "pokemonDetailSegue", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailSegue" {
            let vc = segue.destination as! PokemonDetailViewController
            vc.pokemon = pokemonIndexSelect
        }
    }
    
}

//MARK: -UISearchBarDelegate
extension PokemonListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchPokemon = dataSource.filter({ $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searching = true
        self.tableView.reloadData()
    }
    
}
