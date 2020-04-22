//
//  ApiPokemonList.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - AutorizationToken
struct ApiGenericList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GenericSummary]?
}

// MARK: - Result
struct GenericSummary: Codable {
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

// MARK: - apiName
struct apiName: Codable {
    let language: GenericSummary?
    let name: String?
}
