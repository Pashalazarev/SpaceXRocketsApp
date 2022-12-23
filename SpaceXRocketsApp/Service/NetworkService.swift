//
//  NetworkService.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import UIKit


// MARK: - URL links
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
    
    let greenViewController = UIViewController()
    let redViewController = UIViewController()
    let blueViewController = UIViewController()
    
    private init() {
        rocketDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        launchDecoder.keyDecodingStrategy = .convertFromSnakeCase
        launchDecoder.dateDecodingStrategy = .iso8601
        
        let rocketDateFormatter = DateFormatter()
        rocketDateFormatter.dateFormat = "yyyy-MM-dd"
        rocketDecoder.dateDecodingStrategy = .formatted(rocketDateFormatter)
        
        greenViewController.view.backgroundColor = .green
        redViewController.view.backgroundColor = .red
        blueViewController.view.backgroundColor = .blue
        
    }
    
    //MARK: Public methods
    func fetchRockets(completion: @escaping(Result<[Rocket], NetworkError>) -> Void) {
        makeRequest(url: Links.roscketUrl, jsonDecoder: rocketDecoder, completion: completion)
    }
    
    func fetchLaunches(completion: @escaping(Result<[Launch], NetworkError>) -> Void) {
        makeRequest(url: Links.launchUrl, jsonDecoder: launchDecoder, completion: completion)
    }
    
    // MARK: - Private method
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
                let response = try self.launchDecoder.decode(Response.self, from: data)
                completion(.success(response))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}


