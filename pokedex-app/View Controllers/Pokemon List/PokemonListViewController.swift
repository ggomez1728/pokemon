//
//  PokemonListViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class PokemonListViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PokemonListViewModel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }

    override func viewDidAppear(_ animated: Bool) {
        let nav = navigationController?.navigationBar
        nav?.backgroundColor = .white
        nav?.tintColor = .black
        nav?.topItem?.title = "Pokemon"
          
    }
    
    // MARK: - Actions

    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    /// Configure VC
    private func configureVC() {
        configureNavigationBar()
        configureTableView()
    }

    /// Configure VC
     private func configureNavigationBar() {
        guard  let nav = navigationController?.navigationBar else {
            return
        }
        nav.backgroundColor = .white
        nav.tintColor = .black
        nav.topItem?.title = "Pokemon"
     }

    /// Configure tableview
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension;
        tableView.separatorStyle = .none
        Utilities.registerCellsFor(tableView: tableView)
    }
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.cellIdentifier, for: indexPath) as? PokemonTableViewCell {
           // cell.configureCellWith(dataSource: cellViewModel, delegate: self)
            return cell
        }
      
        return UITableViewCell()
    }
    
    
}
