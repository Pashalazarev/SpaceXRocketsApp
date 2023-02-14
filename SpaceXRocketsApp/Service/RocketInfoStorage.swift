//
//  RocketScreenData.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 06.02.2023.
//

import Foundation

struct Section {
    let title: String?
    let section: SectionType
    let cell: [CellType]
}

private let dateFormatter = DateFormatter()

extension Section {
    
    enum SectionType {
        case imageHeader
        case verticalInfo
        case horizontalInfo
    }
    
    enum CellType {
        case rocketImage(url: URL, rocketName: String)
        case verticalInfo(value: String, text: String)
        case horizontalInfo(title: String, value: String)
        case button
    }
    
    static func getSection(rocket: Rocket) -> [Section] {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let heightValue: String
        let height: String
        if Settings.SettingsType.height == .height {
            heightValue = rocket.height.meters.formatted()
            height = Settings.Units.meters.rawValue
        } else {
            heightValue = rocket.height.feet.formatted()
            height = Settings.Units.feets.rawValue
        }
        
        let diametrValue: String
        let diametr: String
        if Settings.SettingsType.diameter == .diameter {
            diametrValue = rocket.diameter.meters.formatted()
            diametr = Settings.Units.meters.rawValue
        } else {
            diametrValue = rocket.diameter.feet.formatted()
            diametr = Settings.Units.feets.rawValue
        }
        
        let weightValue: String
        let weight: String
        if Settings.SettingsType.weight == .weight {
            weightValue = rocket.mass.kg.formatted()
            weight = Settings.Units.kilograms.rawValue
        } else {
            weightValue = rocket.mass.lb.formatted()
            weight = Settings.Units.pounds.rawValue
        }
        
        let payloadValue: String
        let payload: String
        if Settings.SettingsType.payload == .payload{
            payloadValue = rocket.payloadWeights[0].kg.formatted()
            payload = Settings.Units.kilograms.rawValue
        } else {
            payloadValue = rocket.payloadWeights[1].lb.formatted()
            payload = Settings.Units.pounds.rawValue
        }
        return [
            Section(
                title: nil,
                section: .imageHeader,
                cell: [
                    .rocketImage(url: rocket.flickrImages[0], rocketName: rocket.name)
                ]
            ),
            Section(
                title: nil,
                section: .horizontalInfo,
                cell: [
                    .verticalInfo(value: heightValue, text: height),
                    .verticalInfo(value: diametrValue, text: diametr),
                    .verticalInfo(value: weightValue, text: weight),
                    .verticalInfo(value: payloadValue, text: payload)
                ]
            ),
            Section(title: nil,
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Первый запуск", value: dateFormatter.string(from: rocket.firstFlight)),
                        .horizontalInfo(title: "Страна", value: rocket.country),
                        .horizontalInfo(title: "Стоимость запуска", value: rocket.costPerLaunch.formatted())
                    ]
                   ),
            Section(title: "Первая ступень",
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Количество двигателей", value: rocket.firstStage.engines.formatted()),
                        .horizontalInfo(title: "Количество топлива", value: rocket.firstStage.fuelAmountTons.formatted()),
                        .horizontalInfo(title: "Время сгорания", value: rocket.firstStage.burnTimeSec?.formatted() ?? "")
                    ]
                   ),
            Section(title: "Вторая ступень",
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Количество двигателей", value: rocket.secondStage.engines.formatted()),
                        .horizontalInfo(title: "Количество топлива", value: rocket.secondStage.fuelAmountTons.formatted()),
                        .horizontalInfo(title: "Время сгорания", value: rocket.secondStage.burnTimeSec?.formatted() ?? "")
                    ]
                   ),
            Section(title: nil,
                    section: .horizontalInfo,
                    cell: [.button]
                   )
        ]
    }
}
