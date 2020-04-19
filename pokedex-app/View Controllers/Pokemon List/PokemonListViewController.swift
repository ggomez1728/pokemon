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
    var viewModel: PokemonListViewModel!

    // MARK: - View Life Cycle
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        let bundle = Bundle(for: PokemonListViewController.classForCoder())
        super.init(nibName: PokemonListViewController.identifier, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getFunctionalities()
        configureVC()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFunctionalities()
    }
    
    // MARK: - Actions

    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    /// Configure VC
    private func configureVC() {
        viewModel.delegate = self
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
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        tableView.addGestureRecognizer(longPress)
        
        Utilities.registerCellsFor(tableView: tableView)

    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print(indexPath)
             }
        }
    }
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPokemonRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellViewModel = viewModel.viewModel(for: indexPath),  let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.cellIdentifier, for: indexPath) as? PokemonTableViewCell {
            cell.configureCellWith(dataSource: cellViewModel)
            return cell
        }
      
        return UITableViewCell()
    }
}


extension PokemonListViewController: PokemonListViewModelDelegate {
    func refreshList() {
        tableView.reloadData()
    }
}
