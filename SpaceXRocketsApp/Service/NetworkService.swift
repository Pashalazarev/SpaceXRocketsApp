//
//  NetworkService.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import Foundation

private enum Links {
    static let roscketUrl = "https://api.spacexdata.com/v4/rockets"
    static let launchUrl = "https://api.spacexdata.com/v4/launches"
}

final class NetworkService {
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
    
// MARK: - Properties
    
    static let shared = NetworkService()
    
    private let rocketDecoder = JSONDecoder()
    private let launchDecoder = JSONDecoder()
    
    private init() {
        rocketDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        launchDecoder.keyDecodingStrategy = .convertFromSnakeCase
        launchDecoder.dateDecodingStrategy = .iso8601
        
        let rocketDateFormatter = DateFormatter()
        rocketDateFormatter.dateFormat = "yyyy-MM-dd"
        rocketDecoder.dateDecodingStrategy = .formatted(rocketDateFormatter)
        
    }
    
    func fetchRockets(completion: @escaping(Result<[Rocket], NetworkError>) -> Void) {
        makeRequest(url: Links.roscketUrl, jsonDecoder: rocketDecoder, completion: completion)
        
    }
    
    func fetchLaunches(completion: @escaping(Result<[Launch], NetworkError>) -> Void) {
        makeRequest(url: Links.launchUrl, jsonDecoder: launchDecoder, completion: completion)
    }
}
// MARK: - Private method

private extension NetworkService {
    
    private func makeRequest<Response: Decodable>(
        url: String,
        jsonDecoder: JSONDecoder,
        completion: @escaping (Result<Response, NetworkError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let response = try jsonDecoder.decode(Response.self, from: data)
                completion(.success(response))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
