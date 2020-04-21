//
//  EvolutionCellViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

protocol EvolutionCellViewModelDataSource: class {
    var evolutionChain: (GenericSummary?, GenericSummary?, Int) { get }

}

protocol EvolutionCellViewModelDelegate: class {
    func refresh(data: (GenericSummary?, GenericSummary?, Int))
}

class EvolutionCellViewModel: BaseCellViewModel, EvolutionCellViewModelDataSource {

    // MARK: - Properties
    weak var delegate: EvolutionCellViewModelDelegate?
    var evolutionChain: (GenericSummary?, GenericSummary?, Int)
    
    // MARK: - View Life Cycle
    init(evolutionChain: (GenericSummary?, GenericSummary?, Int)) {
        self.evolutionChain = evolutionChain
    }

    // MARK: - Public Methods
    
    func loadEvolutionChain() {
        delegate?.refresh(data: evolutionChain)
    }
    // MARK: - Private Methods
}
