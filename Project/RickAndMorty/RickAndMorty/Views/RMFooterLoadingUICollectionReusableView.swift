//
//  RMFooterLoadingUICollectionReusableView.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/26.
//

import UIKit

final class RMFooterLoadingUICollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properites
    static let identifier = "RMFooterLoadingUICollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not support NSCoder init")
    }
    
    // MARK: - Setup
    private func addConstraints() {
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
    
    public func stopAnimating() {
        
    }
}
