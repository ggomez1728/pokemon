//
//  MoveDetaailTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/21/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class MoveDetailTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    var viewModel: MoveDetailCellViewModel!
    
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(viewModel: MoveDetailCellViewModel) {
           self.viewModel = viewModel
           self.viewModel.delegate = self
           configureVC()
           self.viewModel.loadMove()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Private Methods
    private func configureVC() {
        
    }
}

extension MoveDetailTableViewCell: MoveDetailCellViewModelDelegate{
    func refresh(data:  (move: String?, type: String?, level: Int)) {
        moveLabel.text = data.move
        levelLabel.text = data.type
        guard let typeName = data.type else { return }
        typeImage.image = UIImage(named: "Types-\(typeName.capitalized)")
    }
}
