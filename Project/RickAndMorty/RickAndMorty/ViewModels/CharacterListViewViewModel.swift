//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

class CharacterListViewViewModel: NSObject {
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharacterRequests, type: RMGetAllCharactersResponse.self) { result in
            switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

// 이를 상속하기 위해서는 NSObject를 채택한 class 여야 함
// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                                                            for: indexPath) as? RMCharacterCollectionViewCell else  {
            fatalError("Not support cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: "test",
            characterStatus: .alive,
            characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
