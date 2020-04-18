//
//  PokemonTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

protocol PokemonCellDataSource: class {
    var avatarImage: String? { get }
    var name: String? { get }
    var number: Int? { get }
    var typeImage1: String? { get }
    var typeImage2: String? { get }
}

class PokemonTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var mainTypeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var secondaryTypeImage: UIImageView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Actions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public Methods
    /**
     Configure cell with dataSource and delegate
     
     - parameter dataSource: DataSource to configure cell
     - parameter delegate: Delegate to configure cell
     */
    func configureCellWith(dataSource: PokemonCellDataSource) {
        //addCardLabel.text = dataSource.addCardText
    }
    
}
