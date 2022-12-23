//
//  Rocket.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import Foundation

struct Rocket: Decodable {
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
    struct Height: Decodable {
        let feet: Double
        let meters: Double
    }
    
    struct Diameter: Decodable {
        let feet: Double
        let meters: Double
    }
    
    struct Mass: Decodable {
        let kg: Double
        let lb: Double
    }
    
    struct PayloadWeights: Decodable {
        let id: String
        let kg: Double
        let lb: Double
    }
    
    struct FirstStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Double?
    }
    
    struct SecondStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Double?
    }
}
