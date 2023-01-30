//
//  NetworkManager.swift
//  NetworkingSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import SwiftUI


struct News: Decodable, Identifiable {
    var id: Int
    var title: String
    var strap: String
    var url: URL
}

struct Message: Decodable, Identifiable {
    var id: Int
    var from: String
    var text: String
}

struct EndPoint<T: Decodable> {
    var path: String
    var type: T.Type
    var method = HTTPMethod.get
    var headers = [String: String]()
}

extension EndPoint where T == [News] {
    static let headlines = EndPoint(path: "headlines.json", type: [News].self)
    static let inValidURL = EndPoint(path: "inValidURL", type: [News].self)
}

extension EndPoint where T == [Message] {
    static let messages = EndPoint(path: "messages.json", type: [Message].self)
}

//extension EndPoint where T == [String: String] {
//    static let userText = EndPoint(url: URL(string: "https://reqres.in/api/users")!,
//                                   type: [String: String].self,
//                                   method: .post,
//                                   headers: ["Content_Type": "application/json"])
//
//    // let user = ["name": "Bilbo Baggins", "job": "Ring Courier"]
//    // let response = try await networkManager.fetch(.userText,
//    //                                               with: JSONEncoder().encode(user))
//    // print(response)
//}

struct NetworkManager {
    
    var enviroment: AppEnviroment
    
    func fetch<T>(_ resource: EndPoint<T>, with data: Data? = nil) async throws -> T {
        
        guard let url = URL(string: resource.path, relativeTo: enviroment.baseURL) else {
            throw URLError(.unsupportedURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = resource.headers
        request.httpBody = data
        
        var (data, _) = try await enviroment.session.data(for: request)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
    
    func fetch<T>(_ resource: EndPoint<T>, with data: Data? = nil, attempts: Int, retryDelay: Double = 1) async throws -> T {
        do {
            print("Attempting to fetch (Attempts remaining: \(attempts)")
            return try await fetch(resource, with: data)
        } catch {
            if attempts > 1 {
                try await Task.sleep(for: .milliseconds(Int(retryDelay * 1000)))
                return try await fetch(resource, with: data, attempts: attempts - 1, retryDelay: retryDelay)
            } else {
                throw error
            }
        }
    }
    
    func fetch<T>(_ resource: EndPoint<T>, with data: Data? = nil, defaultValue: T) async throws -> T {
        do {
            return try await fetch(resource, with: data)
        } catch {
            return defaultValue
        }
    }
}

enum HTTPMethod: String {
    case delete
    case get
    case patch
    case post
    case put
    
    var rawValue: String {
        return String(describing: self).uppercased()
    }
}

struct AppEnviroment {
    var name: String
    var baseURL: URL
    var session: URLSession
    
    static let production = AppEnviroment(
        name: "Production",
        baseURL: URL(string: "https://hws.dev")!,
        session: {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "APIKey": "production-key-from-keychain" // 실제로는 keychain 등을 통해 사용
            ]
            return URLSession(configuration: configuration)
        }())
    
    #if DEBUG
    static let testing = AppEnviroment(
        name: "Testing",
        baseURL: URL(string: "https://hws.dev")!,
        session: {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            configuration.httpAdditionalHeaders = [
                "APIKey": "test-key"
            ]
            return URLSession(configuration: configuration)
        }()
    )
    #endif
}

struct NetworkManagerKey: EnvironmentKey {
    static var defaultValue = NetworkManager(enviroment: .testing)
}

extension EnvironmentValues {
    var networkManager: NetworkManager {
        get {
            self[NetworkManagerKey.self]
        } set {
            self[NetworkManagerKey.self] = newValue
        }
    }
}
