//
//  ApiPokemonList.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - AutorizationToken
struct ApiPokemonList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonSummary]?
}

// MARK: - Result
struct PokemonSummary: Codable {
    let name: String?
    let url: String?
}
