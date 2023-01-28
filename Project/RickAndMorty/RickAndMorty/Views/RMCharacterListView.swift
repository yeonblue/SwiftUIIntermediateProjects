//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ chracterListView: RMCharacterListView, didSelectChracter character: RMCharacter)
}

/// show list of charaters, loader, etc.
class RMCharacterListView: UIView {

    // MARK: - Properties
    private let viewModel = CharacterListViewViewModel()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        collectionView.isHidden = true
        collectionView.alpha = 0 // animation을 위함
        
        collectionView.register(
            RMFooterLoadingUICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingUICollectionReusableView.identifier
        )
        
        return collectionView
    }()
       
    public weak var delegate: RMCharacterListViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(spinner, collectionView)
        
        addConstraints()
        
        spinner.startAnimating()
        setupCollectionView()
        viewModel.fetchCharacters()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not support NSCoder init")
    }
    
    // MARK: - Setup
    private func addConstraints() {
        spinner.snp.makeConstraints({
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}

extension RMCharacterListView: RMCharcterListViewModelDelegate {
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1.0
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectChracter: character)
    }
    
    func didLoadMoreCharacters(with newIndexPath: [IndexPath]) {

        collectionView.performBatchUpdates {
            // performBatchUpdates(:completion:) 사용 시 이점: completion 활용 가능
            // 아니면 여러 개의 변경을 동시에 animate하고 싶을 때, 추가로 performBatchUpdates는 delete를 우선 작업 주의
            collectionView.insertItems(at: newIndexPath)
        } completion: { _ in
            
        }
    }
}
