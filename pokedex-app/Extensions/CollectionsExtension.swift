//
//  CollectionsExtension.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import Foundation

// MARK: - Collection Extension
extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    func safeContains(_ index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
