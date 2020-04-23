//
//  WeaknessesTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class WeaknessesDetailTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    var viewModel: WeaknessesDetailViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureVC()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.loadDamageFrom()
    }
    
    func config(viewModel: WeaknessesDetailViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        configureVC()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Private Methods
    private func configureVC() {
        configureCollectionView()
        
    }
    
    /// Configure tableview
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        Utilities.registerCellsFor(collectionView: collectionView)
    }
}

extension WeaknessesDetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfitemsRows()
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


extension WeaknessesDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width - 18.0, height: 42)
    }
}

extension WeaknessesDetailTableViewCell: WeaknessesDetailViewModelDelegate{
    func load(_ pokemon: GenericSummary) {
        
    }
    
    func loadDamage() {
        collectionView.reloadData()
    }
    
    
}
