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
    private let characterListView = CharacterListView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(characterListView)
        characterListView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
