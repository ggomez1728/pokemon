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

class WeaknessesDetailViewModel: BaseCellViewModel, WeaknessesDetailViewModelDataSource {
    
    // MARK: - Properties
    var damageList: [(String, String)] = []
    weak var delegate: WeaknessesDetailViewModelDelegate?
    var pokemon: GenericSummary

    
    // MARK: - View Life Cycle
    init(pokemon: GenericSummary) {
        self.pokemon = pokemon
    }
    
    func viewModel(for indexPath: IndexPath) -> (String, String)? {
        damageList.safeContains(indexPath.row)
    }
    
    // MARK: - Public Methods
    /// Method that returns pokemon rows number
    func numberOfitemsRows() -> Int {
        damageList.count
    }
    
    // MARK: - Private Methods
    /// Load Damage from.
    func loadDamageFrom() {
        let info = PokemonManager.share.getTypeInfo(for: pokemon.name ?? "").compactMap({$0?.info?.damageRelations})
        let doubleDamageFrom = info.compactMap({$0.doubleDamageFrom}).flatMap({$0}).compactMap({($0.name)}).map({("X2", $0)})
        let halfDamageFrom = info.compactMap({$0.halfDamageFrom}).flatMap({$0}).compactMap({$0.name}).map({("X0.5", $0)})
        let noDamageFrom = info.compactMap({$0.noDamageFrom}).flatMap({$0}).compactMap({$0.name}).map({("-", $0)})
        damageList.append(contentsOf: doubleDamageFrom)
        damageList.append(contentsOf: halfDamageFrom)
        damageList.append(contentsOf: noDamageFrom)
        delegate?.loadDamage()
    }
}
