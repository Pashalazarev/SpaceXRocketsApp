//
//  RocketScreenData.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 06.02.2023.
//

import Foundation

struct Section: Hashable {
    let title: String?
    let section: SectionType
    let cell: [CellType]
}

extension Section {
    
    enum SectionType {
        case imageHeader
        case verticalInfo
        case horizontalInfo
        case button
    }
    
    enum CellType: Equatable, Hashable {
        case rocketImage(url: URL, rocketName: String)
        case verticalInfo(value: String, text: String)
        case horizontalInfo(title: String, value: String)
        case button
    }
}
