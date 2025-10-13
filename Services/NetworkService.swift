import Foundation
import SwiftUICore

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

protocol NetworkProtocol {
    func fetchTopHeadlines() async throws -> NewsModel
    func fetchCategory(category: String) async throws -> NewsModel
}

final class NetworkService: NetworkProtocol {
    static let shared = NetworkService()
    private let logger: LoggerProtocol
    private let topHeadlinesURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    private let API = "604d23cfdd174a448e6d3d4e5dcb8342"
    
    private init(){
        logger = LoggerService.logger
        logger.log(message: "NetworkService started!", logLevel: .info)
    }
    
    func fetchTopHeadlines() async throws -> NewsModel {
        let urlRequest = topHeadlinesURL + API
        let url = URL(string: urlRequest)
        guard let url = url else {
            logger.log(message: "NetworkService. Inavalid URL", logLevel: .error)
            throw NetworkError.invalidURL
        }
        let (data, result) = try await URLSession.shared.data(from: url)
        logger.log(message: "NetworkService. Received data [Result: \(result), Data: \(String(decoding: data, as: UTF8.self))]", logLevel: .debug)
        
        if let res = result as? HTTPURLResponse {
            if res.statusCode != 200 {
                logger.log(message: "NetworkService. RequestFailed [Status code: \(res.statusCode)]", logLevel: .error)
                throw NetworkError.requestFailed
            }
            
            do {
                return try JSONDecoder().decode(NewsModel.self, from: data)
            } catch {
                logger.log(message: "NetworkService. DecodingFailed", logLevel: .error)
                throw NetworkError.decodingFailed
            }
        }
        logger.log(message: "NetworkService. RequestFailed", logLevel: .error)
        throw NetworkError.requestFailed
    }
    
    func fetchCategory(category: String) async throws -> NewsModel {
        let urlRequest = "https://newsapi.org/v2/everything?q=\(category)&from=\(date())&sortBy=date&apiKey=" + API
        let url = URL(string: urlRequest)
        guard let url = url else {
            logger.log(message: "NetworkService. Inavalid URL", logLevel: .error)
            throw NetworkError.invalidURL
        }
        let (data, result) = try await URLSession.shared.data(from: url)
        logger.log(message: "NetworkService. Received data [Result: \(result), Data: \(String(decoding: data, as: UTF8.self))]", logLevel: .debug)
        
        if let res = result as? HTTPURLResponse {
            if res.statusCode != 200 {
                logger.log(message: "NetworkService. RequestFailed [Status code: \(res.statusCode)]", logLevel: .error)
                throw NetworkError.requestFailed
            }
            
            do {
                return try JSONDecoder().decode(NewsModel.self, from: data)
            } catch {
                logger.log(message: "NetworkService. DecodingFailed", logLevel: .error)
                throw NetworkError.decodingFailed
            }
        }
        logger.log(message: "NetworkService. RequestFailed", logLevel: .error)
        throw NetworkError.requestFailed
    }
    
}

private func date() -> String {
    let date = Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? Date.now
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}

struct NetworkServiceKey: EnvironmentKey {
    static let defaultValue: NetworkProtocol = NetworkService.shared
}

extension EnvironmentValues {
    var networkService: NetworkProtocol {
        get { self[NetworkServiceKey.self] }
        set { self[NetworkServiceKey.self] = newValue }
    }
}
