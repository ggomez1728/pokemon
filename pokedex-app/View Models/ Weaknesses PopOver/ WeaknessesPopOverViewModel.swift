//
//   WeaknessesPopOverViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/19/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

protocol WeaknessesPopOverViewModelDataSource: class {
    var pokemon: GenericSummary { get }
}

protocol WeaknessesPopOverViewModelDelegate: class {
    func load(_ pokemon: GenericSummary)
    func loadDamage()
}

class WeaknessesPopOverViewModel: WeaknessesPopOverViewModelDataSource {
    
    // MARK: - Properties
    var pokemon: GenericSummary
    weak var delegate: WeaknessesPopOverViewModelDelegate?
    var damageList: [(String, String)] = []

    // MARK: - View Life Cycle
    init(pokemon: GenericSummary) {
        self.pokemon = pokemon
    }
    

    // MARK: - Public Methods
    func showPokemon() {
        loadDamageTo()
        delegate?.load(pokemon)
    }
   
    /// Method that returns pokemon rows number
    func numberOfitemsRows() -> Int {
        return damageList.count
    }
    
    /// View model for indexPath
    /// - Parameter indexPath: IndexPath to get viewModel
    /// - Returns: ViewModel if any
    func viewModel(for indexPath: IndexPath) -> (String, String)? {
        return damageList.safeContains(indexPath.row)
    }
    
    // MARK: - Private Methods
    func loadDamageTo() {
        let info = PokemonManager.share.getTypeInfo(for: pokemon.name ?? "").compactMap({$0?.info?.damageRelations})
        let doubleDamageTo = info.compactMap({$0.doubleDamageTo}).flatMap({$0}).compactMap({($0.name)}).map({("X2", $0)})
        let halfDamageTo = info.compactMap({$0.halfDamageTo}).flatMap({$0}).compactMap({$0.name}).map({("X0.5", $0)})
        let noDamageTo = info.compactMap({$0.noDamageTo}).flatMap({$0}).compactMap({$0.name}).map({("-", $0)})
        damageList.append(contentsOf: doubleDamageTo)
        damageList.append(contentsOf: halfDamageTo)
        damageList.append(contentsOf: noDamageTo)
        delegate?.loadDamage()
    }
    
    
}

