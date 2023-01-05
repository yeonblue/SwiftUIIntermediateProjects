//
//  PhotoModelDataService.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    private init() {
        downloadData()
    }
    
    @Published var photoModel: [PhotoModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
            } receiveValue: { [weak self] returnedValue in
                self?.photoModel = returnedValue
            }
            .store(in: &cancellable)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
