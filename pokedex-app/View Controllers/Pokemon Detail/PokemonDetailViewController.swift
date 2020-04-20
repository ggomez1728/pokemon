//
//  PokemonDetailViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/19/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: PokemonDetailViewModel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokemonDetailView: UIView!
    @IBOutlet weak var cardScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleSecondaryLabel: UILabel!
    
    // MARK: - View Life Cycle
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        let bundle = Bundle(for: PokemonDetailViewController.classForCoder())
        super.init(nibName: PokemonDetailViewController.identifier, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        hideNavigationBar(false)
    }
    
    @IBAction func sectionTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel.load(section: .stats)
        case 2:
            viewModel.load(section: .evolutions)
        default:
            viewModel.load(section: .moves)
        }
    }
    
    // MARK: - Private Methods
    private func  configureNavigationBar() {
        hideNavigationBar(true)
    }
    
    private func configureScrollView() {
        cardScrollView.delegate = self
        Utilities.addCornerRadiusTo(cardScrollView.layer, cornerRadius: 35)
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
    
    private func configureVC() {
        viewModel.delegate = self
        configureNavigationBar()
        configureScrollView()
        configureTableView() 
        Utilities.addGradient(backgroundView.layer, bounds: backgroundView.bounds, colors: BackgroundColors.bug)
        Utilities.addCornerRadiusTo(cardView.layer, cornerRadius: 35)
    }
    
    private func hideNavigationBar(_ state: Bool) {
        navigationController?.setNavigationBarHidden(state, animated: false)
    }
}

// MARK: - PokemonDetailViewModelDelegate
extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    
    func refreshList() {
        tableView.reloadData()
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.cellIdentifier, for: indexPath) as! SkillsTableViewCell
        return cell
    }
    
    
}

extension PokemonDetailViewController: UITableViewDelegate {
    
}

// MARK: - UIScrollViewDelegate
extension PokemonDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView == cardScrollView else {
            return
        }
        let yContentOffset = scrollView.contentOffset.y
        if pokemonDetailView.isHidden {
            hideElementsFromView(state: yContentOffset > 0)
        } else {
            hideElementsFromView(state: yContentOffset > 60)
            if yContentOffset > 60 {
                avatarImage.layoutIfNeeded()
            }
        }
        view.layoutIfNeeded()
    }
    
    func hideElementsFromView(state: Bool) {
        avatarImage.isHidden = state
        titleSecondaryLabel.isHidden = !state
        pokemonDetailView.isHidden = state
        pokemonDetailView.layoutIfNeeded()
        cardView.layoutIfNeeded()
       
    }
}
