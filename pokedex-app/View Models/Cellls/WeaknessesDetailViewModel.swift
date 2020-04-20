//
//  WeaknessesDetailViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

protocol WeaknessesDetailViewModelDataSource: class {
    var pokemon: GenericSummary { get }
}

protocol WeaknessesDetailViewModelDelegate: class {
    func load(_ pokemon: GenericSummary)
    func loadDamage()
}

class WeaknessesDetailViewModelViewModel: WeaknessesDetailViewModelDataSource {
    
    // MARK: - Properties
    var pokemon: GenericSummary
    weak var delegate: WeaknessesDetailViewModelDelegate?
    
    
    // MARK: - View Life Cycle
    init(pokemon: GenericSummary) {
        self.pokemon = pokemon
    }
    
    
    func viewModel(for indexPath: IndexPath) -> (String, String)? {
        ("", "")
    }

}
