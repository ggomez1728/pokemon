//
//  ApiEvolutionPokemon.swift
//  pokedex-app
//
//  Created by German Gomez on 4/20/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - APIEvolutionPokemon
struct ApiEvolutionPokemon: Codable {
    let chain: ApiChain?
    let id: Int?
    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}

// MARK: - Chain
struct ApiChain: Codable {
    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [ApiChain]?
    let isBaby: Bool?
    let species: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let minLevel: Int?
    let needsOverworldRain: Bool?
    let timeOfDay: String?
    let trigger: GenericSummary?
    let turnUpsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case trigger
        case turnUpsideDown = "turn_upside_down"
        case timeOfDay
    }
}
