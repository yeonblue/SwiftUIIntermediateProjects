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
    
    enum SectionType: CaseIterable {
        case photo
        case infomation
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    // MARK: - Computed Properties
    public var title: String {
        return character.name.uppercased()
    }
    
    public var requestURL: URL? {
        return URL(string: character.url)
    }
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
}
