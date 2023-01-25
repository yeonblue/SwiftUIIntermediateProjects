//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

/// show list of charaters, loader, etc.
class CharacterListView: UIView {

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
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isHidden = true
        collectionView.alpha = 0 // animation을 위함
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(spinner, collectionView)
        
        addConstraints()
        
        spinner.startAnimating()
        setupCollectionView()
        viewModel.fetchCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupport Xib")
    }
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.spinner.stopAnimating()
            
            self?.collectionView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self?.collectionView.alpha = 1.0
            }
        }
    }
}
