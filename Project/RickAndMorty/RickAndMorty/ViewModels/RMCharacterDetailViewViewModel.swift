//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/26.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    // MARK: - Properties
    private let character: RMCharacter
    
    // MARK: - Computed Properties
    public var title: String {
        return character.name.uppercased()
    }
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
}
