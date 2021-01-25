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
import ActionSheetPicker_3_0
import SwiftUI
import NotificationBannerSwift

class PokemonListViewController: BaseViewController{
    
    
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryButton: UIButton!
    
    //MARK: -IBAction
    @IBAction func likeButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "pokemonLikeSegue", sender: nil)
    }
    
    
    //MARK: - Properties
    private let pokemonListViewModel = PokemonListViewModel()
    private let cellId = "PokemonTableViewCell"
    private var dataSource = [Pokemon]()
    private var pokemonIndexSelect = Pokemon()
    private var searchPokemon = [Pokemon]()
    private var searching = false
    private var generations: [Int:String] = [1:"generation-i", 2:"generation-ii", 3:"generation-iii", 4:"generation-iv", 5: "generation-v"]

    override func viewDidLoad() {
        super.viewDidLoad()
        septupUI()
        bind()
        pokemonListViewModel.input.nameGeneration.accept(("generation-vi",1,20))
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
        
        let sectorSelection = Observable.of(categoryButton.rx.tap).merge()
        sectorSelection.asObservable().subscribe(
            onNext: {
                self.perform(#selector(self.dismissKeyboard))
                self.showCategories(self.categoryButton, generationList: self.generations)
            }
        ).disposed(by: disposeBag)
        
    }
    
    
    public func showCategories(_ sender: UIButton, generationList: [Int: String]) {
        let sectorsOrdered = Array(generationList.values.map { $0 }.sorted(by: { $0 < $1 }))
        let actionSheetPicker = ActionSheetStringPicker(title: "Generations", rows: sectorsOrdered, initialSelection: 0, doneBlock: { _, _, value in
            self.categoryButton.setTitle(value as! String?, for: .normal)
            self.categoryButton.setTitleColor(.white, for: .normal)
            self.dataSource.removeAll()
            self.tableView.reloadData()
            self.pokemonListViewModel.input.nameGeneration.accept((value as? String, 1, 20))

            return
        }, cancel: { _ in

            return
        }, origin: sender)

        actionSheetPicker?.setDoneButton(UIBarButtonItem(title: "Accept", style: .plain, target: nil, action: nil))
        actionSheetPicker?.setCancelButton(UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil))
        if #available(iOS 13.0, *) {
            actionSheetPicker?.pickerBackgroundColor = .tertiarySystemBackground
        }
        actionSheetPicker?.show()
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
        return 100.0
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
        
        if segue.identifier == "pokemonLikeSegue" {
            let vc = segue.destination as! LikeViewController
            vc.pokemon = dataSource
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
