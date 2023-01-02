//
//  StorageManager.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 28.12.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let rocketKey = "rocketKey"
    
    let rocketDecoder = JSONDecoder()
    let rocketEncoder = JSONEncoder()
    
    private init() {}

// MARK: - Methods for userDefaults
        
    func saveRocketData(settings: Rocket) {
        var rockets = fetchRocketData()
        rockets.append(settings)
        guard let data = try? rocketEncoder.encode(rockets) else { return }
        
        userDefaults.set(data, forKey: rocketKey)
    }
    
    func fetchRocketData() ->[Rocket] {
        guard let data = userDefaults.data(forKey: rocketKey) else {
            return []
        }
        guard let rockets = try? rocketDecoder.decode([Rocket].self, from: data) else { 
            return []
        }
        return rockets
    }
}
