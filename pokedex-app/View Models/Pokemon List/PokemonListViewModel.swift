//
//  PokemonListViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation
protocol PokemonListViewModelDataSource: class {
    var pokemonList: [GenericSummary] { get }
}

protocol PokemonListViewModelDelegate: class {
    func refreshList()
}

class PokemonListViewModel: PokemonListViewModelDataSource {
    
    // MARK: - Properties
    weak var delegate: PokemonListViewModelDelegate?
    var pokemonList: [GenericSummary] = []
    var pokemonListData: [GenericSummary] = []
    
    // MARK: - Public Methods
    /// Filter by string
    /// - Parameter searchText: text for filter
    func applyFilter(searchText: String?) {
        guard let searchText = searchText, searchText != "" else {
            pokemonList = pokemonListData
            delegate?.refreshList()
            return
        }
        pokemonList = pokemonListData.compactMap({$0.name?.lowercased().contains(searchText.lowercased()) == true ? $0 : nil})
        delegate?.refreshList()
    }
    
    /// Obtain basic functionalities
    func getFunctionalities() {
        PokemonManager.share.getTypes { [weak self] updated in
            self?.getPokemons(offset: 0)
        }
    }
    
    /// Method that configures flag country image to present and prepares countries for picker
    func getPokemons(offset: Int) {
        PokemonManager.share.getPokemonList(offset: offset) { [weak self] (pokemons, error) in
            if let error = error {
                switch error {
                case .unexpectedError:
                    break
                default:
                    break
                }
                return
            }
            self?.pokemonList = pokemons
            self?.pokemonListData = pokemons
            self?.delegate?.refreshList()
        }
    }
    
    /// Method that returns pokemon rows number
    func numberOfPokemonRows() -> Int {
        return pokemonList.count
    }

    /// View model for indexPath
    /// - Parameter indexPath: IndexPath to get viewModel
    /// - Returns: ViewModel if any
    func viewModel(for indexPath: IndexPath) -> GenericSummary? {
        return pokemonList.safeContains(indexPath.row)
    }
}
