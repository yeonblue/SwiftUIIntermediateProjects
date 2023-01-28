//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/28.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
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
    
    public func configure(viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
