//
//  ImageLoadingViewModel.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let urlString: String
    let imageKey: String
    var cancellable = Set<AnyCancellable>()
    
    let manager = PhotoModelFileManager.instance
    
    init(url: String, key: String) {
        self.urlString = url
        self.imageKey = key
        getImage()
    }
    
    func downloadImage() {
        
        print("Download start")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
            } receiveValue: { [weak self] image in
                guard let self = self, let image = image else { return }
                self.image = image
                self.manager.add(key: self.imageKey, image: image)
            }
            .store(in: &cancellable)
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Get Saved Image!")
        } else {
            downloadImage()
            print("Download Image")
        }
    }
}
