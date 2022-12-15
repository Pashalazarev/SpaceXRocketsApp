//
//  NetworkService.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import UIKit

private enum Links {
    static let roscketUrl = "https://api.spacexdata.com/v4/rockets"
    static let launchUrl = "https://api.spacexdata.com/v4/launches"
}

final class NetworkService {
    
    // MARK: - Properties
    
    static let shared = NetworkService()
    
    private let decoder = JSONDecoder()
    private let formatter = DateFormatter()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    //MARK: - Network errors
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
    
    //MARK: Publick methods
    func fetchRockets(completion: @escaping(Result<[Rocket], NetworkError>) -> Void) {
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let url = URL(string: Links.roscketUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let rockets = try self.decoder.decode([Rocket].self, from: data)
                completion(.success(rockets))
                
            }
            catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
    func fetchLaunches(completion: @escaping(Result<[Launch], NetworkError>) -> Void) {
        decoder.dateDecodingStrategy = .iso8601
        
        guard let url = URL(string: Links.launchUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let launches = try self.decoder.decode([Launch].self, from: data)
                completion(.success(launches))
                
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    // TO DO: -  написать универсальную функцию, func makeRequest<Response: Decodable>(url: String, completion: @escaping (Response) -> Void
}
