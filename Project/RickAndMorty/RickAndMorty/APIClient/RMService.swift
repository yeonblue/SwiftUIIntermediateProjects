//
//  RMService.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/24.
//

import Foundation


/// Rick And Morty 데이터를 얻기 위한 API service object
final class RMService {
    
    /// shared singleton instance
    static let shared = RMService()
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// API Call 함수
    /// - Parameters:
    ///   - request: request 객체,
    ///   - type: Codable Type
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(rmRequest: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(RMServiceError.failedToGetData))
                return
            }
            
            do {
                // let json = try JSONSerialization.jsonObject(with: data)
                // print(String(describing: json))
                
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Private
    private func request(rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
