//
//  DownloadImageViewModel.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import Foundation
import Combine

class DownloadImageViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscrivers()
    }
    
    func addSubscrivers() {
        dataService.$photoModel
            .sink { [weak self] returnedValue in
                self?.dataArray = returnedValue
            }
            .store(in: &cancellable)
    }
}
