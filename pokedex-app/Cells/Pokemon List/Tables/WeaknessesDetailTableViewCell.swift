//
//  WeaknessesTableViewCell.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class WeaknessesDetailTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: WeaknessesDetailViewModelViewModel?
    
   func config(viewModel: WeaknessesDetailViewModelViewModel) {
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellViewModel = viewModel?.viewModel(for: indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeaknessesCollectionViewCell.cellIdentifier, for: indexPath) as! WeaknessesCollectionViewCell
            cell.configureCell(with: cellViewModel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}


extension WeaknessesDetailTableViewCell: UICollectionViewDelegate {
    
}

