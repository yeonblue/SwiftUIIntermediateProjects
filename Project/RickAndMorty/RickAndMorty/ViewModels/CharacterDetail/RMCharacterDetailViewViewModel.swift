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
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case infomation(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
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
        setupSections()
    }
    
    // MARK: - Setup
    func setupSections() {
        sections = [
            .photo(viewModel: .init()),
            .infomation(viewModels: [
                .init(), .init(), .init(), .init(), .init(), .init(), .init(), .init()
            ]),
            .episodes(viewModels: [.init(), .init(), .init(), .init(), .init()])
        ]
    }
}
