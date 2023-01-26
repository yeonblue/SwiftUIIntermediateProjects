//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import Foundation

struct RMCharacterCollectionViewCellViewModel {
    
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
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
