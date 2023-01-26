//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

protocol RMCharcterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

class CharacterListViewViewModel: NSObject {
    
    // MARK: - Properties
    public weak var delegate: RMCharcterListViewModelDelegate?
    private var charcters: [RMCharacter] = [] {
        didSet {
            for charcter in charcters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: charcter.name,
                    characterStatus: charcter.status,
                    characterImageURL: URL(string: charcter.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []

    // MARK: - Functions
    public func fetchCharacters() {
        RMService.shared.execute(.listCharacterRequests, type: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
                case .success(let result):
                    let results = result.results
                    self?.charcters = results
                
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
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
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                                                            for: indexPath) as? RMCharacterCollectionViewCell else  {
            fatalError("Not support cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
