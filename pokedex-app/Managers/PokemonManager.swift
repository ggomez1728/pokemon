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
}

class PokemonManager {

    // MARK: - Public Methods
    static func getPokemonList(offset: Int, completion: @escaping ([PokemonSummary], PokError?) -> Void) {
        AF.request(getPaginatedEndPoint(for: PokemonApiEndpoint.pokemonList, offset: offset))
          .validate()
          .responseDecodable(of: ApiPokemonList.self) { response in
            guard let response = response.value else {
                completion([], PokError.withOutData)
                return
            }
            completion(response.results ?? [], nil)
        }
    }
    
    // MARK: - Private Methods
    static private func getEndPoint(for urlStructure: String) -> String {
        String(format: "%@%@", kUrlBase, urlStructure)
    }

    static private func getPaginatedEndPoint(for urlStructure: String, offset: Int, limit: Int = 60) -> String {
        String(format: "%@%@?limit=%d&offset=%d", kUrlBase, urlStructure, limit, offset)
    }
}


