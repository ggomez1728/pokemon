//
//  PokemonManager.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation
import Alamofire

struct PokemonApiEndpoint {
    public static let pokemonList = "pokemon"
    public static let pokemonTypes = "type"

}

struct TypePokemonInfo {
    var info: APIPokemonType?
    let name: String
    var updated: Bool
}

class PokemonManager {

    static let share = PokemonManager()
    
    var pokemonTypes: [String: TypePokemonInfo] = [:]
    
    // MARK: - Static Methods

    static func getPokemonImageUrl(for pokemonNumber: String) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonNumber).png"
    }
    
    static func getPokemonIndex(from pokemonUrl: String?) -> String? {
         pokemonUrl?.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "").replacingOccurrences(of: "/", with: "")
    }
    
    // MARK: - Public Methods
    
    func getPokemonList(offset: Int, completion: @escaping ([GenericSummary], PokError?) -> Void) {
        AF.request(getPaginatedEndPoint(for: PokemonApiEndpoint.pokemonList, offset: offset))
          .validate()
          .responseDecodable(of: ApiGenericList.self) { response in
            guard let response = response.value else {
                completion([], PokError.withOutData)
                return
            }
            completion(response.results ?? [], nil)
        }
    }
    
    func getTypes( completion: @escaping (Bool) -> Void) {
        AF.request(getEndPoint(for: PokemonApiEndpoint.pokemonTypes))
            .validate()
            .responseDecodable(of: ApiGenericList.self) { response in
                guard let response = response.value else {
                    return
                }
                response.results?.forEach({ pokemonType in
                    if let name =  pokemonType.name, let urlType = pokemonType.url {
                        self.pokemonTypes[name] = TypePokemonInfo(info: nil, name: name, updated: false)
                        self.getTypeDetail(for: urlType) { (status) in
                            if self.checkUpdatedTypes() {
                                completion(true)
                            }
                        }
                    }
                })
        }
    }
    
    func getTypeDetail(for type: String, completion: @escaping (Bool) -> Void) {
        AF.request(type).validate()
        .responseDecodable(of: APIPokemonType.self) { response in
            guard let response = response.value, let name = response.name else {
                return
            }
            self.pokemonTypes[name] = TypePokemonInfo(info: response, name: name, updated: true)
            completion(true)
        }
    }
    
    func getTypeImages(for pokemonName: String) -> [String] {
        pokemonTypes.compactMap({self.check(pokemonName, in: $0.value.info?.pokemon ?? []) ? $0.key : nil})
    }
    
    func getTypeInfo(for pokemonName: String) -> [TypePokemonInfo?] {
        pokemonTypes.compactMap({self.check(pokemonName, in: $0.value.info?.pokemon ?? []) ? $0.value : nil})
    }
 
    
    // MARK: - Private Methods
    
    private func check(_ pokemonName: String, in list: [ApiPokemon]) -> Bool {
        (list.first(where: {$0.pokemon?.name == pokemonName}) != nil)
    }
    
    private func checkUpdatedTypes() -> Bool {
        (pokemonTypes.first(where: {$0.value.updated == false}) == nil)
    }
    
    private func getEndPoint(for urlStructure: String) -> String {
        String(format: "%@%@", kUrlBase, urlStructure)
    }

    private func getPaginatedEndPoint(for urlStructure: String, offset: Int, limit: Int = 200) -> String {
        String(format: "%@%@?limit=%d&offset=%d", kUrlBase, urlStructure, limit, offset)
    }
}


