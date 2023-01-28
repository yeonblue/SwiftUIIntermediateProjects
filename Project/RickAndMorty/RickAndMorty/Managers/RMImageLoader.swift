//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/27.
//

import Foundation

final class RMImageLoader {
    
    static let shared = RMImageLoader()
    private init() {}
    
    // MARK: - Properties
    private var imageDataCache = NSCache<NSString, NSData>()
    
    // MARK: - Functions
    
    /// Get Image content from URL
    /// - Parameters:
    ///   - url: soucre url
    ///   - completion: callback
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            return completion(.success(data as Data))
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil, let self = self else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let key = url.absoluteString as NSString
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
