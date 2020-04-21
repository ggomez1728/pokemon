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
    func loadMainInfo(pokemon: GenericSummary)
    func load(description: String)
    func refreshList()
}

class PokemonDetailViewModel: PokemonDetailViewModelDataSource {
    
    // MARK: - Properties
    weak var delegate: PokemonDetailViewModelDelegate?
    private var currentSection: PokemonSection = .stats
    private var sections: [PokemonSection: [BaseCellViewModel]] = [:]
    private var pokemon: GenericSummary
    
    // MARK: - View Life Cycle
    init(pokemon: GenericSummary) {
        self.pokemon = pokemon
    }
    
    // MARK: - Public Methods
    func fillSections() {
        sections[.stats] = [SkillsCellViewModel(), WeaknessesDetailViewModel(pokemon: pokemon)]
        loadPokemonSpecies(name: pokemon.name ?? "")
        delegate?.loadMainInfo(pokemon: pokemon)
        getStats()
    }
    
    func load(section: PokemonSection) {
        currentSection = section
        switch section {
        case .stats:
            getStats()
        case .evolutions:
            getEvolutions()
            break
        case .moves:
            getMoves()
        }
    }
    
    func loadEvolutions(_ url: String) {
        PokemonManager.share.getEvolutionChain(url: url) {[weak self] (evolutionChain) in
            self?.sections[.evolutions] = evolutionChain.map({EvolutionCellViewModel(evolutionChain: $0)})
            if self?.currentSection == .evolutions {
                self?.delegate?.refreshList()
            }
        }
    }
    
    func loadPokemonSpecies(name pokemon: String) {
        PokemonManager.share.getPokemonSpecies(name: pokemon) {[weak self] (pokemonSpecies) in
            if let evolutionChainUrl = pokemonSpecies.evolutionChain?.url {
                self?.loadEvolutions(evolutionChainUrl)
            }
            
            let flavorTextEntries = pokemonSpecies.flavorTextEntries?.first(where: {$0.language?.name == Locale.current.languageCode})
            self?.delegate?.load(description: flavorTextEntries?.flavorText ?? "" )
            
        }
    }
    
    /// Method that returns pokemon rows number
    func numberOfPokemonRows() -> Int {
        return sections[currentSection]?.count ?? 0
    }

    /// View model for indexPath
    /// - Parameter indexPath: IndexPath to get viewModel
    /// - Returns: ViewModel if any
    func viewModel(for indexPath: IndexPath) -> BaseCellViewModel? {
        return sections[currentSection]?.safeContains(indexPath.row)
    }
    
    // MARK: - Private Methods
    private func getEvolutions() {
        delegate?.refreshList()
    }
    
    private func getMoves() {
        delegate?.refreshList()
    }

    private func getStats() {
        delegate?.refreshList()
    }

}

enum PokemonSection {
    case stats
    case evolutions
    case moves
}
