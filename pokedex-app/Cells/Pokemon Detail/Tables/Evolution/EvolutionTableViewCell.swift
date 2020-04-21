//
//  EvolutionTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class EvolutionTableViewCell: BaseTableViewCell {

    var viewModel: EvolutionCellViewModel!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var avatarPokemonFromImage: UIImageView!
    @IBOutlet weak var avatarPokemonToImage: UIImageView!

    @IBOutlet weak var pokemonFromLabel: UILabel!
    @IBOutlet weak var pokemonToLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        levelLabel.text = nil

    }
    
    func config(viewModel: EvolutionCellViewModel) {
        self.viewModel = viewModel
        self.viewModel.delegate = self
        configureVC()
        self.viewModel.loadEvolutionChain()
    }
    
    private func configureVC() {
        
    }
    
}

extension EvolutionTableViewCell: EvolutionCellViewModelDelegate {
    
    func refresh(data: (GenericSummary?, GenericSummary?, Int)) {
        levelLabel.text = "Lv.\(data.2)"
        pokemonFromLabel.text = data.0?.name
        pokemonToLabel.text = data.1?.name
        
        Utilities.setImageOf(url: PokemonManager.getPokemonImageUrl(for: PokemonManager.getPokemonIndex(from: data.0?.url) ?? ""), to: avatarPokemonFromImage, placeholder: nil)
        Utilities.setImageOf(url: PokemonManager.getPokemonImageUrl(for: PokemonManager.getPokemonIndex(from: data.1?.url) ?? ""), to: avatarPokemonToImage, placeholder: nil)

    }
}
