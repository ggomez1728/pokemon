//
//  SkillsTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class SkillsTableViewCell: BaseTableViewCell {
   
    // MARK: - Properties
    var viewModel: SkillsCellViewModel?
    
    // MARK: - View Life Cycle
    
    func config(viewModel: SkillsCellViewModel) {
        self.viewModel = viewModel
        
    }

    // MARK: - Private Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
