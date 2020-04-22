//
//  ApiPokemonType.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - APIPokemonType
struct APIPokemonType: Codable {
    let damageRelations: DamageRelations?
    let gameIndices: [GameIndex]?
    let generation: GenericSummary?
    let id: Int?
    let moveDamageClass: GenericSummary?
    let moves: [GenericSummary]?
    let name: String?
    let names: [ApiName]?
    let pokemon: [ApiPokemon]?

    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case gameIndices = "game_indices"
        case generation, id
        case moveDamageClass = "move_damage_class"
        case moves, name, names, pokemon
    }
}

// MARK: - DamageRelations
struct DamageRelations: Codable {
    let doubleDamageFrom, doubleDamageTo, halfDamageFrom: [GenericSummary]?
    let halfDamageTo, noDamageFrom, noDamageTo: [GenericSummary]?
    
    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int?
    let generation: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case generation
    }
}



// MARK: - Pokemon
struct ApiPokemon: Codable {
    let pokemon: GenericSummary?
    let slot: Int?
}
