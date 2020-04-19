//
//  WeaknessesCollectionViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/19/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class WeaknessesCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var multiplierLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
    }
    
    func configureCellWith(dataSource: (String, String)) {
        typeImage.image = UIImage(named: "Types-\(dataSource.1.capitalized)")
        multiplierLabel.text = dataSource.0
    }
    
    // MARK: - Private Methods
    /**
     Configure cell
     */
    private func configureCell() {
        backgroundColor = .clear
        typeImage.image = UIImage(named: "logo")
        multiplierLabel.text = "X2"
        multiplierLabel.text = nil
    }
}
