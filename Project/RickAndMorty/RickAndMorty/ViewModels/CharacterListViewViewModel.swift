//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

protocol RMCharcterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
}

/// CharacterListView를 handle하는 ViewModel
class CharacterListViewViewModel: NSObject {
    
    // MARK: - Properties
    public weak var delegate: RMCharcterListViewModelDelegate?
    
    /// 추가 페이지를 로딩중인지 여부
    private var isLoadingMoreCharacters: Bool = false
    
    private var charcters: [RMCharacter] = [] {
        didSet {
            for charcter in charcters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: charcter.name,
                    characterStatus: charcter.status,
                    characterImageURL: URL(string: charcter.image)
                )
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var apiInfo: Info? = nil
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []

    // MARK: - Functions
    
    /// fetch initial set of character(20)
    public func fetchCharacters() {
        RMService.shared.execute(.listCharacterRequests, type: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
                case .success(let result):
                    let results = result.results
                    self?.charcters = results
                    self?.apiInfo = result.info
                
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    /// more load if additionoal chracters are needed
    public func fetchAdditionalChracters(url: URL) {
        
        guard isLoadingMoreCharacters == false else {
            return
        }
        
        isLoadingMoreCharacters = true
        
        // fetch more chracters
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
        
        print("Fetching more chracters: \(url.absoluteString)")
        RMService.shared.execute(request, type: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let result):
                    let moreResults = result.results
                    self.apiInfo = result.info
                
                    let originalCount = self.charcters.count
                    let newCount = moreResults.count
                    let total = originalCount + newCount
                    let startIndex = total - newCount
                    self.charcters.append(contentsOf: moreResults)
                
                    let indexPathsToAdd: [IndexPath] = Array(startIndex..<(startIndex + newCount)).compactMap {
                        return IndexPath(row: $0, section: 0)
                    }

                    DispatchQueue.main.async {
                        self.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                        self.isLoadingMoreCharacters = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowLoadmoreIndicator: Bool {
        return apiInfo?.next != nil
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = charcters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              shouldShowLoadmoreIndicator,
              let footer = collectionView.dequeueReusableSupplementaryView(
                      ofKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: RMFooterLoadingUICollectionReusableView.identifier,
                      for: indexPath
                  ) as? RMFooterLoadingUICollectionReusableView else {
            fatalError("Not support")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadmoreIndicator else {
            return .zero
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}

// MARK: - UIScrollViewDelegate
// CollectionView는 UIScrollView도 상속하므로
extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadmoreIndicator,
              !isLoadingMoreCharacters,
              let nextURLStr = apiInfo?.next, let url = URL(string: nextURLStr) else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height // 스크롤 뷰 실제 content 크기
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        // print(offset, totalContentHeight, totalScrollViewFixedHeight) // 0.0 3185.0 700.0
        // -100은 어느정도 offset
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
            fetchAdditionalChracters(url: url)
        }
    }
}
