//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/26.
//

import UIKit
import SnapKit

/// chracter 정보 상세 표시 Viewcontroller
final class RMCharacterDetailViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: RMCharacterDetailViewViewModel
    let detailView: RMCharacterDetailView
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not support NSCoder init")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        view.backgroundColor = .systemBackground
        view.addSubviews(detailView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShareButton))
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    // MARK: - Setup
    private func addConstraints() {
        detailView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func didTapShareButton() {
        
        // share chracter info
    }
    
    // MARK: - Functions
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
        } else if indexPath.section == 2 {
            cell.backgroundColor = .gray
        }
        
        return cell
    }
}
