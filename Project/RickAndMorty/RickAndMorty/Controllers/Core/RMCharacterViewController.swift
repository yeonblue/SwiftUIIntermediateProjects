//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/23.
//

import UIKit
import SnapKit

/// show and search for characters
final class RMCharacterViewController: UIViewController {

    // MARK: - Properties
    private let characterListView = RMCharacterListView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        characterListView.delegate = self
        setupView()
    }
    
    func setupView() {
        view.addSubview(characterListView)
        characterListView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension RMCharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ chracterListView: RMCharacterListView, didSelectChracter character: RMCharacter) {
        
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
