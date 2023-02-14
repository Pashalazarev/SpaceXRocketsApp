//
//  Rocket.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import Foundation

struct Rocket: Codable {
    let name: String
    let height: Height
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeights]
    let firstFlight: Date
    let country: String
    let costPerLaunch: Double
    let firstStage: FirstStage
    let secondStage: SecondStage
    let flickrImages: [URL]
}

extension Rocket {
    struct Height: Codable {
        let feet: Double
        let meters: Double
    }
    
    struct Diameter: Codable {
        let feet: Double
        let meters: Double
    }
    
    struct Mass: Codable {
        let kg: Double
        let lb: Double
    }
    
    struct PayloadWeights: Codable {
        let kg: Double
        let lb: Double
    }
    
    struct FirstStage: Codable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Double?
    }
    
    struct SecondStage: Codable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Double?
    }
        
}
