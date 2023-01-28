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
        
        let sectionType = viewModel.sections[section]
        switch sectionType {
            case .photo(_):
                return 1
            case .infomation(viewModels: let viewModels):
                return viewModels.count
            case .episodes(viewModels: let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier,
                    for: indexPath
                ) as? RMCharacterPhotoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(viewModel: viewModel)
                cell.backgroundColor = .yellow
                return cell
            case .infomation(viewModels: let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier,
                    for: indexPath
                ) as? RMCharacterInfoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(viewModel: viewModels[indexPath.row])
                cell.backgroundColor = .systemGreen
                return cell
            case .episodes(viewModels: let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier,
                    for: indexPath
                ) as? RMCharacterEpisodeCollectionViewCell else {
                    fatalError()
                }
                cell.configure(viewModel: viewModels[indexPath.row])
                cell.backgroundColor = .systemCyan
                return cell
        }
    }
}
