//
//  SettingsTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 10.01.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    var onSettingsChanged: ((Int) -> Void)?
    
    @IBOutlet var settingsTypeLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func settingsUnitAction() {
        onSettingsChanged?(segmentedControl.selectedSegmentIndex)
    }
}
