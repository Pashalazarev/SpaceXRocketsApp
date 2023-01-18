//
//  SettingsTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 10.01.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    @IBOutlet private var settingsTypeLabel: UILabel!
    @IBOutlet private var segmentedControl: UISegmentedControl!

    var onSettingsChanged: ((Int) -> Void)?
    
    func configure(settings: Settings) {
        settingsTypeLabel.text = settings.type.rawValue
        segmentedControl.setTitle(settings.unit.first?.rawValue, forSegmentAt: 0)
        segmentedControl.setTitle(settings.unit.last?.rawValue, forSegmentAt: 1)
        
        onSettingsChanged = { selectedIndex in
            UserDefaults.standard.set(selectedIndex, forKey: settings.type.rawValue)
        }
        segmentedControl.self.selectedSegmentIndex = UserDefaults.standard.integer(forKey: settings.type.rawValue )
    }
  
    @IBAction func settingsUnitAction() {
        onSettingsChanged?(segmentedControl.selectedSegmentIndex)
    }
}
