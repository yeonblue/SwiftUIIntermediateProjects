//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/26.
//

import UIKit
import SnapKit

/// View for single character info
final class RMCharacterDetailView: UIView {

    // MARK: - Properties
    var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    private var viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - Init
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemGreen
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not support NSCoder init")
    }
    
    // MARK: - Setup
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }
    
    private func createSection(for sectionIdx: Int) -> NSCollectionLayoutSection {
        
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIdx] {
            case .photo:
                return createPhotoSectionLayout()
            case .infomation:
                return createInfoSectionLayout()
            case .episodes:
                return createEpisodesSectionLayout()
        }
    }
    
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
       
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
       
        return section
    }
    
    private func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
       
        return section
    }
}
