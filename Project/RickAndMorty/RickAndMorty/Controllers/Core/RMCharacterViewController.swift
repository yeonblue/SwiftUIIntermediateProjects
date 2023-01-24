//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/23.
//

import UIKit

/// show and search for characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        
        let request = RMRequest(
            endPoint: .character,
            queryParam: [.init(name: "name", value: "rick"),
                         .init(name: "status", value: "alive")]
        )

        RMService.shared.execute(request,
                                 type: RMCharacter.self) { result in
            switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
