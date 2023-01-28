//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/28.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not support NSCoder init")
    }
    
    // MARK: - Setup
    
    func setupConstraints() {
        
    }
    
    public func configure(viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
