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
        configureCell()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
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
     */
    func configureCellWith(dataSource: GenericSummary) {
        nameLabel.text = dataSource.name
        configure(PokemonManager.share.getTypeImages(for: dataSource.name ?? "").map({"Types-\($0.capitalized)"}))
        if let pokemonIndex = dataSource.url?.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "").replacingOccurrences(of: "/", with: "") {
            let pokemonImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonIndex).png"
            if let pokemonIndex = Int(pokemonIndex) {
                numberLabel.text = String(format:"#%03d", pokemonIndex)
            }
            Utilities.setImageOf(url: pokemonImageUrl, to: avatarImage, placeholder: nil )
            
        }
    }
    
    // MARK: - Private Methods
    
    private func configure(imageUrlType: String?, imageView: UIImageView) {
        if let imageUrlType = imageUrlType {
            imageView.isHidden = false
            imageView.image = UIImage(named: imageUrlType)
        }
    }
    
    private func configure(_ typeImages: [String]) {
        if !typeImages.isEmpty {
            configure(imageUrlType: typeImages.safeContains(0), imageView: mainTypeImage)
            configure(imageUrlType: typeImages.safeContains(1), imageView: secondaryTypeImage)
            
        }
    }
    /**
     Configure cell
     */
    private func configureCell() {
        backgroundColor = .clear
        mainTypeImage.isHidden = true
        secondaryTypeImage.isHidden = true
        nameLabel.text = ""
        numberLabel.text = ""
        avatarImage.image = nil
    }
}
