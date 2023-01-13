//
//  StorageManager.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 28.12.2022.
//

import Foundation

struct Settings {
    let type: SettingsType
    let unit: [Units]
    let selectedUnit: Units
}

extension Settings {
    
    enum SettingsType: String {
        case height = "Высота"
        case diameter = "Диаметр"
        case weight = "Масса"
        case payload = "Полезная нагрузка"
    }
    
    enum Units: String {
        case meters = "m"
        case feets = "ft"
        case kilograms = "kg"
        case pounds = "lb"
    }
    
   static func availableSettings() -> [Settings] {
        [
            Settings(type: .height, unit: [.meters, .feets], selectedUnit: .meters),
            Settings(type: .diameter, unit: [.meters, .feets], selectedUnit: .meters),
            Settings(type: .weight, unit: [.kilograms, .pounds], selectedUnit: .kilograms),
            Settings(type: .payload, unit: [.kilograms, .pounds], selectedUnit: .kilograms)
        ]
    }
}

final class StorageSettings {

    static let shared = StorageSettings()

    private let userDefaults = UserDefaults.standard
    
    private init() {}
}

extension StorageSettings {
    
    func saveUserSettings(setting: Settings.SettingsType, value: Settings.Units) {
        userDefaults.set(value.rawValue, forKey: setting.rawValue)
    }
    
    func getUserSettings(setting: Settings.SettingsType) -> Settings.Units? {
        guard let getUnit = userDefaults.string(forKey: setting.rawValue) else { return nil }
        return Settings.Units(rawValue: getUnit)
    }
}
