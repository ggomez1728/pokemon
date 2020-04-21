//
//  SkillsCellViewModel.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

protocol SkillsCellViewModelDataSource: class {
    
}

protocol SkillsCellViewModelDelegate: class {

}

class SkillsCellViewModel: BaseCellViewModel, SkillsCellViewModelDataSource {
    
    weak var delegate: SkillsCellViewModelDelegate?

}
