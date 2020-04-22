//
//  MoveDetailCellViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/21/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

protocol MoveDetailCellViewModelDataSource: class {
    var move:  (move: String?, type: String?, level: Int){ get }

}

protocol MoveDetailCellViewModelDelegate: class {
    func refresh(data:  (move: String?, type: String?, level: Int))
}

class MoveDetailCellViewModel: BaseCellViewModel, MoveDetailCellViewModelDataSource {
    
    var move: (move: String?, type: String?, level: Int)
    
    // MARK: - Properties
    weak var delegate: MoveDetailCellViewModelDelegate?
    
    // MARK: - View Life Cycle
    init(move: (move: String?, type: String?, level: Int)) {
        self.move = move
    }
    
    func loadMove() {
        delegate?.refresh(data: move)
    }

}
