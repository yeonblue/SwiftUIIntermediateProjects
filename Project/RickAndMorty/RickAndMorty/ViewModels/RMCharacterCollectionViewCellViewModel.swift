//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import Foundation

struct RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    // MARK: - Properties
    let characterName: String
    let characterStatus: RMCharacterStatus
    let characterImageURL: URL?
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.rawValue)"
    }
    
    // MARK: - Init
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageURL: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    // MARK: - Functions
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoader.shared.downloadImage(url) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
