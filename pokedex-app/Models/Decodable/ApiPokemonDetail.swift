//
//  ApiPokemonDetail.swift
//  pokedex-app
//
//  Created by German Gomez on 4/21/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - APIPokemonDetail
struct APIPokemonDetail: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [GenericSummary]?
    let gameIndices: [apiGameIndex]?
    let height: Int?
    let id: Int?
    let isDefault: Bool
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let species: GenericSummary?
    let sprites: apiSpritesDetail?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order, species, sprites, stats, types, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: GenericSummary?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}



// MARK: - GameIndex
struct apiGameIndex: Codable {
    let gameIndex: Int?
    let version: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Move
struct Move: Codable {
    let move: GenericSummary?
    let versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - Sprites
struct apiSpritesDetail: Codable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: GenericSummary?
}
