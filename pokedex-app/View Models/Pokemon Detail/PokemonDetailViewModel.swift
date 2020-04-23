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
    func loadMainInfo(type: GenericSummary)
    func load(description: String)
    func refreshList()
}

class PokemonDetailViewModel: PokemonDetailViewModelDataSource {
    
    // MARK: - Properties
    private var currentSection: PokemonSection = .stats
    weak var delegate: PokemonDetailViewModelDelegate?
    private var pokemon: GenericSummary
    private var sections: [PokemonSection: [BaseCellViewModel]] = [:]
    
    var moves: [String?: ApiMoveDetail?] = [:]
    
    // MARK: - View Life Cycle
    init(pokemon: GenericSummary) {
        self.pokemon = pokemon
    }
    
    // MARK: - Public Methods
    
    /// Create move model
    /// - Parameter move: ApiMoveDetail
    func createMoveModel(move: ApiMoveDetail?) -> (move: String?, type:  String?, level: Int){
        (move: move?.names?.first(where: {$0.language?.name == Locale.current.languageCode})?.name, type:  move?.type?.name, level: 0)
    }
    
    /// Fill all sections for pokemon detail view
    func fillSections() {
        sections[.stats] = [SkillsCellViewModel(), WeaknessesDetailViewModel(pokemon: pokemon)]
        loadPokemonSpecies(name: pokemon.name ?? "")
        delegate?.loadMainInfo(type: pokemon)
        getPokemonDetailData()
        getStats()
    }
    
    /// Obtain pokemon Detail Data
    func getPokemonDetailData() {
        guard let name = pokemon.name else { return }
        PokemonManager.share.getPokemonDetail(name: name) { pokemonDetail in
            pokemonDetail?.moves?.compactMap({$0.move}).forEach({[weak self] move in
                self?.moves[move.name] = nil
                self?.getMoveDetail(move)
            })
        }
    }
    
    /// Load specific section
    /// - Parameter section: section to load
    func load(section: PokemonSection) {
        currentSection = section
        switch section {
        case .stats:
            getStats()
        case .evolutions:
            getEvolutions()
        case .moves:
            getMoves()
        }
    }
    
    /// Obtain pokemon species.
    /// - Parameter pokemon: pokemon name
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
    
    /// Obtain moves
    private func getMoves() {
        delegate?.refreshList()
    }
    
    /// Obtain move detail
    /// - Parameter move: move structure
    private func getMoveDetail(_ move: GenericSummary) {
        guard let name = move.name, let url = move.url else {
            return
        }
        PokemonManager.share.getMoveDetail(url: url) {[weak self] moveDetail in
            guard let self = self else { return }
            self.moves[name] = moveDetail
            if self.moves.values.first(where: {$0 == nil}) == nil {
                self.sections[.moves] = self.moves.values.compactMap({MoveDetailCellViewModel(move: self.createMoveModel(move: $0))})
            }
        }
    }
    
    /// obtain stats
    private func getStats() {
        delegate?.refreshList()
    }
    
    /// Loal evolution from url
    /// - Parameter url: Url for evolution.
    private func loadEvolutions(_ url: String) {
        PokemonManager.share.getEvolutionChain(url: url) {[weak self] (evolutionChain) in
            self?.sections[.evolutions] = evolutionChain.map({EvolutionCellViewModel(evolutionChain: $0)})
            if self?.currentSection == .evolutions {
                self?.delegate?.refreshList()
            }
        }
    }
}

enum PokemonSection {
    case stats
    case evolutions
    case moves
}
