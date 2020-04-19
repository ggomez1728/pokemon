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
    var pokemonList: [GenericSummary] = []
    weak var delegate: PokemonListViewModelDelegate?
    
    // MARK: - Public Methods
    
    func getFunctionalities() {
        PokemonManager.share.getTypes { [weak self] updated in
            self?.getPokemons(offset: 0)
        }
    }
    
    /// Method that configures flag country image to present and prepares countries for picker
    func getPokemons(offset: Int) {
        PokemonManager.share.getPokemonList(offset: offset) { [weak self] (pokemons, error) in
            if let error = error {
                //Action for Error
                switch error {
                case .unexpectedError:
                    break
                default:
                    break
                }
                return
            }
            self?.pokemonList = pokemons
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

    // MARK: - Private Methods
}
