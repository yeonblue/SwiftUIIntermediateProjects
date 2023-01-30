//
//  ContentView.swift
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
    var url: URL
    var type: T.Type
    var method = HTTPMethod.get
    var headers = [String: String]()
}

extension EndPoint where T == [News] {
    static let headlines = EndPoint(url: URL(string: "https://hws.dev/headlines.json")!,
                                    type: [News].self)
}

extension EndPoint where T == [Message] {
    static let messages = EndPoint(url: URL(string: "https://hws.dev/messages.json")!,
                                   type: [Message].self)
}

extension EndPoint where T == [String: String] {
    static let userText = EndPoint(url: URL(string: "https://reqres.in/api/users")!,
                                   type: [String: String].self,
                                   method: .post,
                                   headers: ["Content_Type": "application/json"])
    
    // let user = ["name": "Bilbo Baggins", "job": "Ring Courier"]
    // let response = try await networkManager.fetch(.userText,
    //                                               with: JSONEncoder().encode(user))
    // print(response)
}

struct NetworkManager {
    func fetch<T>(_ resource: EndPoint<T>, with data: Data? = nil) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = resource.headers
        request.httpBody = data
        
        var (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
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

struct ContentView: View {
    
    @State private var headlines = [News]()
    @State private var messages = [Message]()
    
    let networkManager = NetworkManager()
    
    var body: some View {
        List {
            
            // Headline
            Section("Headlines") {
                ForEach(headlines) { headline in
                    VStack(alignment: .leading) {
                        Text(headline.title)
                            .font(.headline)
                        
                        Text(headline.strap)
                    }
                }
            }
            
            // Message
            Section("Messages") {
                ForEach(messages) { message in
                    VStack(alignment: .leading) {
                        Text(message.from)
                            .font(.headline)
                        
                        Text(message.text)
                    }
                }
            }
        }
        .task {
            do {
                headlines = try await networkManager.fetch(.headlines)
                messages = try await networkManager.fetch(.messages)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
