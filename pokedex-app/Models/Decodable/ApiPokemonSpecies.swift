//
//  ApiPokemonSpecies.swift
//  pokedex-app
//
//  Created by German Gomez on 4/21/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - APIPokemonSpecies
struct APIPokemonSpecies: Codable {
    let baseHappiness, captureRate: Int?
    let color: ApiColor?
    let eggGroups: [ApiColor]?
    let evolutionChain: ApiEvolutionChain?
    let flavorTextEntries: [ApiFlavorTextEntry]?
    let formsSwitchable: Bool?
    let genderRate: Int?
    let genera: [ApiGenus]?
    let generation, growthRate, habitat: ApiColor?
    let hasGenderDifferences: Bool?
    let hatchCounter, id: Int?
    let isBaby: Bool?
    let name: String?
    let names: [ApiName]?
    let order: Int?
    let palParkEncounters: [ApiPalParkEncounter]?
    let pokedexNumbers: [ApiPokedexNumber]?
    let shape: ApiColor?
    let varieties: [ApiVariety]?

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case formsSwitchable = "forms_switchable"
        case genderRate = "gender_rate"
        case genera, generation
        case growthRate = "growth_rate"
        case habitat
        case hasGenderDifferences = "has_gender_differences"
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case name, names, order
        case palParkEncounters = "pal_park_encounters"
        case pokedexNumbers = "pokedex_numbers"
        case shape, varieties
    }
}

// MARK: - Color
struct ApiColor: Codable {
    let name: String?
    let url: String?
}

// MARK: - EvolutionChain
struct ApiEvolutionChain: Codable {
    let url: String?
}

// MARK: - FlavorTextEntry
struct ApiFlavorTextEntry: Codable {
    let flavorText: String?
    let language, version: ApiColor?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}

// MARK: - Genus
struct ApiGenus: Codable {
    let genus: String?
    let language: ApiColor?
}

// MARK: - Name
struct ApiName: Codable {
    let language: ApiColor?
    let name: String?
}

// MARK: - PalParkEncounter
struct ApiPalParkEncounter: Codable {
    let area: ApiColor?
    let baseScore, rate: Int?

    enum CodingKeys: String, CodingKey {
        case area
        case baseScore = "base_score"
        case rate
    }
}

// MARK: - PokedexNumber
struct ApiPokedexNumber: Codable {
    let entryNumber: Int?
    let pokedex: ApiColor?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

// MARK: - Variety
struct ApiVariety: Codable {
    let isDefault: Bool?
    let pokemon: ApiColor?

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
