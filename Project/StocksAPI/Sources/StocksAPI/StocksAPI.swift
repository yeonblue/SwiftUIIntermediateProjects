import Foundation

public struct StocksAPI {

    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    private let baseURL = "https://query1.finance.yahoo.com"
    
    public init() {
        
    }
    
    /// - Parameter url: url
    /// - Returns: 디코딩 된 데이터모델, statusCode값 튜플
    private func fetch<T: Decodable>(url: URL) async throws -> (T, Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validateHTTPResponseCode(response)
        let decodedData = try jsonDecoder.decode(T.self, from: data)
        return (decodedData, statusCode)
    }
    
    private func validateHTTPResponseCode(_ response: URLResponse) throws -> Int {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponseType
        }
        
        guard (200...299).contains(httpResponse.statusCode) || (400...499).contains(httpResponse.statusCode) else {
            throw APIError.httpStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
        }
        
        return httpResponse.statusCode
    }
    
    public func fetchQuotes(symbols: String) async throws -> [Quote] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v7/finance/quote") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [.init(name: "symbols", value: symbols)]
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (QuoteResponse, Int) = try await fetch(url: url)
        
        if let error = response.error {
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        
        return response.data ?? []
    }
    
    public func searchTickers(query: String, isEquityTypeOnly: Bool = true) async throws -> [Ticker] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v1/finance/search") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [
            .init(name: "q", value: query),
            .init(name: "quotesCount", value: "20"),
            .init(name: "lang", value: "en_US")
        ]
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (SearchTickersResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        
        if isEquityTypeOnly {
            return (response.data ?? []).filter {
                ($0.quoteType ?? "").localizedCaseInsensitiveCompare("equity") == .orderedSame
            }
        } else {
            return response.data ?? []
        }
    }
    
    public func fetchChartData(symbol: String, range: ChartRange) async throws -> ChartData? {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v8/finance/chart/\(symbol)") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [
            .init(name: "range", value: range.rawValue),
            .init(name: "interval", value: range.interval),
            .init(name: "indicators", value: "quote"),
            .init(name: "includeTimestamps", value: "true")
        ]
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (response, statusCode): (ChartResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        
        return response.data?.first
    }
}
