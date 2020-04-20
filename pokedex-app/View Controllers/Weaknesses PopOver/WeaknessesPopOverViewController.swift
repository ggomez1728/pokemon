//
//  WeaknessesPopOverViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/19/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class WeaknessesPopOverViewController: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainTypeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var popOverView: UIView!
    @IBOutlet weak var secondaryTypeImage: UIImageView!
    
    private var viewModel: WeaknessesPopOverViewModel

    // MARK: - View Life Cycle
    
    init(viewModel: WeaknessesPopOverViewModel) {
        self.viewModel = viewModel
        let bundle = Bundle(for: WeaknessesPopOverViewController.classForCoder())
        super.init(nibName: WeaknessesPopOverViewController.identifier, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        viewModel.showPokemon()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view != popOverView {
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    // MARK: - Actions

    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func configureVC() {
        viewModel.delegate = self
        configureCollectionView()
        Utilities.addCornerRadiusTo(popOverView.layer, cornerRadius: 16.0)
        Utilities.addShadowTo(popOverView.layer)
        //        Utilities.addShadowAndCorners(layer: popOverView.layer, fillColor: .white, opacity: 0.2, cornerRadius: 18.0, height: 1.0, shadowRadius: 1.0)
        
    }
    
    /// Configure tableview
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        Utilities.registerCellsFor(collectionView: collectionView)
        
    }
    
    private func configure(_ typeImages: [String]) {
        if !typeImages.isEmpty {
            configure(imageUrlType: typeImages.safeContains(0), imageView: mainTypeImage)
            configure(imageUrlType: typeImages.safeContains(1), imageView: secondaryTypeImage)
        }
    }
    
}

// MARK: - WeaknessesPopOverViewModelDelegate
extension WeaknessesPopOverViewController: WeaknessesPopOverViewModelDelegate {
    func loadDamage() {
        collectionView.reloadData()
    }
    
    func load(_ pokemon: GenericSummary) {
        nameLabel.text = pokemon.name
        configure(PokemonManager.share.getTypeImages(for: pokemon.name ?? "").map({"Types-\($0.capitalized)"}))
        if let pokemonIndex = PokemonManager.getPokemonIndex(from: pokemon.url) {
            if let pokemonIndex = Int(pokemonIndex) {
                numberLabel.text = String(format:"#%03d", pokemonIndex)
            }
            Utilities.setImageOf(url: PokemonManager.getPokemonImageUrl(for: pokemonIndex), to: avatarImage, placeholder: nil)
        }
    }
}


extension WeaknessesPopOverViewController: UICollectionViewDelegate {
    
}

extension WeaknessesPopOverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfitemsRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellViewModel = viewModel.viewModel(for: indexPath) {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeaknessesCollectionViewCell.cellIdentifier, for: indexPath) as! WeaknessesCollectionViewCell
            cell.configureCell(with: cellViewModel)
            return cell
        }
       
        
        return UICollectionViewCell()
    }
}

extension WeaknessesPopOverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width - 18.0, height: 42)
    }
}
