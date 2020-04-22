//
//  ApiMoveDetail.swift
//  pokedex-app
//
//  Created by German Gomez on 4/21/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - APIMoveDetail
struct ApiMoveDetail: Codable {
    let contestCombos: ContestCombos?
    let contestEffect: ContestEffect?
    let contestType, damageClass: GenericSummary?
    let effectEntries: [EffectEntry]?
    let flavorTextEntries: [FlavorTextEntry]?
    let generation: GenericSummary?
    let id: Int?
    let machines: [Machine]?
    let meta: Meta?
    let name: String?
    let names: [ApiName]?
    let pastValues: [PastValue]?
    let pp, priority: Int?
    let statChanges: [StatChange]?
    let superContestEffect: ContestEffect?
    let target, type: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case contestCombos = "contest_combos"
        case contestEffect = "contest_effect"
        case contestType = "contest_type"
        case damageClass = "damage_class"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id, machines, meta, name, names
        case pastValues = "past_values"
        case pp, priority
        case statChanges = "stat_changes"
        case superContestEffect = "super_contest_effect"
        case target, type
    }
}

// MARK: - ContestCombos
struct ContestCombos: Codable {
    let normal, contestCombosSuper: apiNormal?

    enum CodingKeys: String, CodingKey {
        case normal
        case contestCombosSuper = "super"
    }
}

// MARK: - Normal
struct apiNormal: Codable {
    let useBefore: [GenericSummary]?
    enum CodingKeys: String, CodingKey {
        case useBefore = "use_before"
    }
}

// MARK: - ContestEffect
struct ContestEffect: Codable {
    let url: String?
}

// MARK: - EffectEntry
struct EffectEntry: Codable {
    let effect: String?
    let language: GenericSummary?
    let shortEffect: String?

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String?
    let language, versionGroup: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}

// MARK: - Machine
struct Machine: Codable {
    let machine: ContestEffect?
    let versionGroup: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case machine
        case versionGroup = "version_group"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let ailment: GenericSummary?
    let ailmentChance: Int?
    let category: GenericSummary?
    let critRate, drain, flinchChance, healing: Int?
    let statChance: Int?

    enum CodingKeys: String, CodingKey {
        case ailment
        case ailmentChance = "ailment_chance"
        case category
        case critRate = "crit_rate"
        case drain
        case flinchChance = "flinch_chance"
        case healing
        case statChance = "stat_chance"
    }
}

// MARK: - PastValue
struct PastValue: Codable {
    let pp: Int?
    let versionGroup: GenericSummary?

    enum CodingKeys: String, CodingKey {
        case pp
        case versionGroup = "version_group"
    }
}

// MARK: - StatChange
struct StatChange: Codable {
    let change: Int?
    let stat: GenericSummary?
}

