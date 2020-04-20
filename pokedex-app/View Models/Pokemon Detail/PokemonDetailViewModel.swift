//
//  PokemonDetailViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/19/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation
protocol PokemonDetailViewModelDataSource: class {
    //var pokemonList: [GenericSummary] { get }
}

protocol PokemonDetailViewModelDelegate: class {
    func refreshList()
}

class PokemonDetailViewModel: PokemonDetailViewModelDataSource {
    
    // MARK: - Properties

    weak var delegate: PokemonDetailViewModelDelegate?

    // MARK: - Public Methods
    
    func load(section: PokemonSection) {
        switch section {
        case .stats:
            break
        case .evolutions:
            break
        case .moves:
            break
        }
    }
    // MARK: - Private Methods

}

enum PokemonSection {
    case stats
    case evolutions
    case moves
}
