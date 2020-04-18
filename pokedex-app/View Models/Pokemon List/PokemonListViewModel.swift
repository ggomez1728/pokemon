//
//  PokemonListViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation
protocol PokemonListViewModelDataSource: class {
    var pokemonList: String? { get }
}

protocol PokemonListViewModelDelegate: class {
    func refreshList()
}

class PokemonListViewModel: PokemonListViewModelDataSource {
    
    var pokemonList: String?
    weak var delegate: PokemonListViewModelDelegate?

      
}
