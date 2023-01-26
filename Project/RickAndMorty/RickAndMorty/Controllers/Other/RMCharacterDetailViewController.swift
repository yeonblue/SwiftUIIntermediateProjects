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
    let viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
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
    }
}
